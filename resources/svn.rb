actions :create, :delete
default_action :create

attribute :name, :kind_of => String, :name_attribute => true, :required => true
attribute :svn_repo, :kind_of => String, :required => true
attribute :svn_revision, :kind_of => String, :default => "HEAD"

attr_accessor :exists