module ApplicationHelper
  def title(*parts)
    unless parts.empty?
      content_for :title do
        'Sales - ' + parts.join(' - ')
      end
    end
  end
end
