RailsAdmin.config do |config|
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.actions do
    # export

    dashboard do
      only ['Response', 'WebSurvey']
    end

    index do
      only ['Response', 'WebSurvey']
    end

    new
    bulk_delete

    show
    edit
    delete

    show_in_app
  end

  config.model 'Question' do
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
    edit do
      exclude_fields :web_survey
    end

    list do
      exclude_fields :id, :answers
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


        # pretty_value do
        #   answers = bindings[:object].answers
        #
        #   qa = ''
        #
        #   answers.each do |answer|
        #     partial :formatted_answers, locals: { answer: answer }
        #   end
        #
        #   qa
        # end
      end
    end
  end

  config.model 'WebSurvey' do
    edit do
      exclude_fields :shortlink_slug,
                     :responses,
                     :questions_web_surveys,
                     :user
    end
  end
end
