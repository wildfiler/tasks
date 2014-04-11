module TasksHelper
  def project_link_to(active, *options)
    li_class = "project-link#{' active' if active}"
    content_tag :li, class: li_class do
      link_to *options
    end
  end
end
