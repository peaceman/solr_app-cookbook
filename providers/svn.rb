use_inline_resources

def whyrun_supported?
	true
end

action :create do
	if @current_resource.exists
		Chef::Log.info "#{@new_resource} already exists - nothing to do."
	else
		converge_by("Fetch Solr-Config from repository #{@new_resource.svn_repo}") do
			fetch_solr_config
		end
	end
end

action :delete do
	unless @current_resource.exists
		Chef::Log.info "#{@new_resource} doesn't exist - nothing to do!"
	else
		converge_by "Delete Solr-Config #{@new_resource.name}" do
			delete_solr_config
		end
	end
end

def load_current_resource
	@current_resource = Chef::Resource::SolrAppSvn.new(@new_resource.name)
	@current_resource.name @new_resource.name
	@current_resource.svn_repo @new_resource.svn_repo
	@current_resource.svn_revision @new_resource.svn_revision

	if solr_config_repo_exists?(@current_resource.name, @current_resource.svn_repo)
		@current_resource.exists = true
	end
end

private

def fetch_solr_config
	target_path = ::File.join(node[:solr_app][:solr_home], new_resource.name)

	subversion target_path do
		repository new_resource.svn_repo
		revision new_resource.svn_revision
		svn_username node[:solr_app][:svn][:username]
		svn_password node[:solr_app][:svn][:password]
		user node[:tomcat][:user]
		group node[:tomcat][:group]
		destination target_path

		action :force_export
	end
end

def delete_solr_config
end

def solr_config_repo_exists?(name, repo)
	false
end