require 'redmine'

require_dependency 'my_projects/view_hook_listener'

Redmine::Plugin.register :my_projects do
  name 'My Projects plugin'
  author 'Nick Peelman'
  description 'Show my assigned projects on the Redmine Homepage'
  version '1.0'
  url 'http://github.com/peelman/my_projects'
  author_url 'http://blog.peelman.us'
end
