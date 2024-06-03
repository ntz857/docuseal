# frozen_string_literal: true

module SubmissionEvents
  TRACKING_PARAM_LENGTH = 6

  # EVENT_NAMES = {
  #   send_email: 'Email sent',
  #   send_reminder_email: 'Reminder email sent',
  #   send_sms: 'SMS sent',
  #   send_2fa_sms: 'Verification SMS sent',
  #   open_email: 'Email opened',
  #   click_email: 'Email link clicked',
  #   click_sms: 'SMS link clicked',
  #   phone_verified: 'Phone verified',
  #   start_form: 'Submission started',
  #   view_form: 'Form viewed',
  #   complete_form: 'Submission completed',
  #   api_complete_form: 'Submission completed via API'
  # }.freeze

  EVENT_NAMES = {
    send_email: '邮件已发送',
    send_reminder_email: '提醒邮件已发送',
    send_sms: '短信已发送',
    send_2fa_sms: '验证短信已发送',
    open_email: '邮件已打开',
    click_email: '邮件链接已点击',
    click_sms: '短信链接已点击',
    phone_verified: '电话已验证',
    start_form: '开始提交',
    view_form: '表格已查看',
    complete_form: '提交已完成',
    api_complete_form: '通过API完成提交'
  }.freeze 

  module_function

  def build_tracking_param(submitter, event_type = 'click_email')
    Base64.urlsafe_encode64(
      [submitter.slug, event_type, Rails.application.secret_key_base].join(':')
    ).first(TRACKING_PARAM_LENGTH)
  end

  def create_with_tracking_data(submitter, event_type, request, data = {})
    SubmissionEvent.create!(submitter:, event_type:, data: {
      ip: request.remote_ip,
      ua: request.user_agent,
      sid: request.session.id.to_s,
      uid: request.env['warden'].user(:user)&.id,
      **data
    }.compact_blank)
  end
end
