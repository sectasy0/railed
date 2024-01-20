# frozen_string_literal: true

module BreadcrumbHelper
  def breadcrumb
    links = []
    case controller_name
    when 'home'
      dashboard_active = true
    when 'servers'
      links << breadcrumb_link(I18n.t('views.dashboard.home.server_list'))
      case action_name
      when 'new'
        links << breadcrumb_link(I18n.t('views.dashboard.home.add_server'), true)
      end
    end

    links.unshift(breadcrumb_link(I18n.t('views.dashboard.home.title'), dashboard_active))
    build_breadcrumb(links)
  end

  def breadcrumb_link(text, active = false, href = '#')
    active_classes = 'text-secondary-700 hover:text-secondary-700'
    normal_classes = 'text-secondary-500 hover:text-secondary-600'
    [
      content_tag(:li, class: 'inline-flex items-center', aria: active ? { current: 'page' } : {}) do
        link_to(text, '', class: active ? active_classes : normal_classes, href:)
      end,
      content_tag(:li, class: 'inline-flex items-center space-x-3') do
        concat(content_tag(:span, '/', class: 'text-secondary-400'))
      end
    ]
  end

  def build_breadcrumb(links)
    content_tag(:nav, aria: { label: 'breadcrumb' }) do
      content_tag(:ol, class: 'inline-flex items-center space-x-2 py-2 text-sm font-medium') do
        links.join.html_safe
      end
    end
  end
end
