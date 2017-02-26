RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancan

  config.actions do
    SUPPORTED = ['Respondent', 'WebSurvey']

    dashboard { only SUPPORTED }
    index { only SUPPORTED }
    new { only ['Question', 'WebSurvey'] }
    show { only ['Response', 'WebSurvey'] }
    edit { only ['WebSurvey'] }

    delete
    bulk_delete
    show_in_app
  end

  #
  # Question
  #
  config.model 'Question' do
    include_fields :question,
                   :question_type

    edit do
      field :question_type, :enum do
        enum do
          [['Up to 255 chars',1],['Long answer',2]]
        end
      end
    end
  end

  #
  # Respondent
  #
  config.model 'Respondent' do
    include_fields :name

    list do
      field :name do
        pretty_value do
          respondent = bindings[:object]
          responses = respondent.responses
          response_id = responses.first ? responses.first.id : ''
          respondent_name = respondent.name.presence || "Anonymous # #{respondent.id}"

          path = "/admin/response/#{response_id}"
          bindings[:view].content_tag :a, respondent_name , href: path
        end
      end

      field :responses do
        pretty_value do
          responses = bindings[:object].responses

          web_survey_id = responses.first ? responses.first.web_survey.id : nil
          web_survey_title = responses.first ? (responses.first.web_survey.title.presence || "Untitled Survey # #{responses.first.web_survey.id}") : nil

          path = "/admin/web_survey/#{web_survey_id}"
          bindings[:view].content_tag :a, "#{web_survey_title}" , href: path, target: '_blank'
        end
      end
    end
  end

  #
  # response
  #
  config.model 'Response' do
    show do
      field :web_survey

      field :name do
        formatted_value{ bindings[:object].respondent.name }
      end

      field :answers do
        pretty_value do
          bindings[:view].render(
            partial: "formatted_answers",
            locals: { response: bindings[:object] }
          )
        end
      end
    end
  end

  #
  # Web Survey
  #
  config.model 'WebSurvey' do
    configure :response_count do
      pretty_value do
        path = "/admin/web_survey/#{bindings[:object].id}"
        bindings[:view].content_tag :a, "#{bindings[:object].responses.count} responses" , href: path
      end

      read_only true
    end

    field :title do
      pretty_value do
        web_survey = bindings[:object]
        web_survey_name = web_survey.title.presence || "Untitled Survey # #{web_survey.id}"

        path = "/admin/web_survey/#{bindings[:object].id}"
        bindings[:view].content_tag :a, web_survey_name, href: path
      end
    end

    field :questions do
      associated_collection_scope do
        web_survey = bindings[:objects]
        Proc.new { |scope|
          scope = scope.where(is_default: false)
        }
      end
    end

    field :shortlink_slug do
      pretty_value do
        path = "/web_survey/#{bindings[:object].shortlink_slug}"
        bindings[:view].content_tag :a, "#{bindings[:object].shortlink_slug}" , href: path, target: '_blank'
      end
    end

    configure :survey_preview do
      pretty_value do
        bindings[:view].render(
          partial: "web_survey_new_questions",
          locals: { web_survey: bindings[:object] }
        )
      end

      read_only true
    end

    list do
      exclude_fields :questions
      include_fields :response_count, :shortlink_slug
    end

    edit do
      exclude_fields :shortlink_slug
      include_fields :survey_preview

      fields do
        help false
      end
    end

    create do
      include_fields :survey_preview

      fields do
        help false
      end
    end

    show do
      include_fields :title, :shortlink_slug

      field :title do
        pretty_value do
          bindings[:object].title.presence || "Untitled Survey # #{bindings[:object].id}'"
        end
      end

      field :questions do
        pretty_value do
          bindings[:view].render(
            partial: "web_survey_show_questions",
            locals: { web_survey: bindings[:object] }
          )
        end
      end

      field :responses do
        pretty_value do
          bindings[:view].render(
            partial: "web_survey_show_responses",
            locals: { web_survey: bindings[:object] }
          )
        end
      end
    end
  end
end
