class PersistChatJob < ApplicationJob
  retry_on StandardError, wait: 5.seconds, attempts: 5
  queue_as :default

  def perform(application_id, number)
    start_time = Time.current
    Rails.logger.info "🔔 PersistChatJob started at #{start_time} | app_id=#{application_id}, number=#{number}"

    application = Application.find_by(id: application_id)
    unless application
      Rails.logger.warn "⚠️ Application not found: id=#{application_id}"
      return
    end

    Chat.find_or_create_by!(
      application_id: application.id,
      number: number
    )

    end_time = Time.current
    Rails.logger.info "✅ PersistChatJob finished at #{end_time} | app_id=#{application_id}, number=#{number} (elapsed #{end_time - start_time} sec)"

  rescue ActiveRecord::RecordNotUnique => e
    Rails.logger.warn "⚠️ Duplicate Chat: app_id=#{application_id}, number=#{number} (#{e.message})"
  rescue StandardError => e
    Rails.logger.error "💥 Error in PersistChatJob: app_id=#{application_id}, number=#{number} | #{e.message}"
    raise
  end
end