class MyProjects < Redmine::Hook::ViewListener
  def view_welcome_index_right(context={})
    load_projects()
  end

  def load_projects()
      html = '<div class="box projects" id="statuses">'
      html += '<h3 class="">My Projects</h3><ul>'
      projects  = Project.visible(User.current).find(:all, :order => "projects.name")
      projects.each do |project|
        if User.current.member_of?(project)
          html += '<li>'
          html += "#{link_to h(project.name), :controller => 'projects', :action => 'show', :id => project }"
          html += '</li>'
        end
      end
      html += '</ul></div>'
      return html
  end
end
