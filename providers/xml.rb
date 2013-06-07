action :create do
	template "solr.xml" do
		path ::File.join(node["solr_app"]["solr_home"], "solr.xml")
		owner node["tomcat"]["user"]
		group node["tomcat"]["group"]
		source "solr.xml.erb"
		cookbook "solr_app"
		variables :collections => new_resource.collections
		notifies :restart, "service[tomcat]"
	end
end