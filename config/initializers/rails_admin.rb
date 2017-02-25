RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with :cancan

  config.actions do
    # export

    dashboard do
      only ['Response', 'WebSurvey', 'Question', 'User']
    end

    index do
      only ['Response', 'WebSurvey', 'Question', 'User']
    end

    new do
      except ['Response']
    end

    bulk_delete

    show do
      only ['Response', 'WebSurvey']
    end

    edit do
      except ['Response']
    end

    delete

    show_in_app
  end

  config.model 'Question' do
    list do
      include_fields :question,
                     :is_default,
                     :created_at
    end

    edit do
      exclude_fields :answers,
                     :is_default,
                     :questions_web_surveys,
                     :web_surveys

      field :question_type, :enum do
        enum do
          [['Up to 255 chars',1],['Long answer',2]]
        end
      end
    end
  end

  config.model 'Response' do
    list do
      include_fields :web_survey,
                     :name,
                     :created_at

      field :name do
        pretty_value do
          path = "/admin/response/#{bindings[:object].id}"
          bindings[:view].content_tag :a, "#{bindings[:object].name}" , href: path, target: '_blank'
        end
      end
    end

    show do
      field :name

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

  config.model 'WebSurvey' do
    navigation_label 'Surveys'
    weight -1

    configure :response_count do
      pretty_value do
        path = "/admin/web_survey/#{bindings[:object].id}"
        bindings[:view].content_tag :a, "#{bindings[:object].responses.count} responses" , href: path
      end

      read_only true
    end

    list do
      include_fields :title,
                     :response_count,
                     :created_at

      field :shortlink_slug do
        pretty_value do
          path = "/web_survey/#{bindings[:object].shortlink_slug}"
          bindings[:view].content_tag :a, "#{bindings[:object].shortlink_slug}" , href: path, target: '_blank'
        end
      end

    end

    edit do
      include_fields :title,
                     :questions

      # Don't include default questions in options
      field :questions do
        associated_collection_scope do
          web_survey = bindings[:objects]
          Proc.new { |scope|
            scope = scope.where(is_default: false)
          }
        end
      end
    end

    show do
      field :title

      field :shortlink_slug do
        pretty_value do
          path = "/web_survey/#{bindings[:object].shortlink_slug}"
          bindings[:view].content_tag :a, "#{bindings[:object].shortlink_slug}" , href: path, target: '_blank'
        end
      end

      field :responses do
        pretty_value do
          bindings[:view].render(
            partial: "formatted_responses",
            locals: { web_survey: bindings[:object] }
          )
        end
      end
    end
  end

  config.model 'User' do
    edit do
      include_fields :username,
                     :email,
                     :is_admin,
                     :password,
                     :password_confirmation
    end
  end
end
