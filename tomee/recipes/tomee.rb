# stop tomcat7 service
service 'tomcat' do
  action :stop
end

# Run a bash shell -  download and extract tomcat
bash "install_tomee" do
     user "root"
     cwd "/usr/share"
     code <<-EOH
           http://apache.mirrors.lucidnetworks.net/tomee/tomee-1.6.0.2/apache-tomee-1.6.0.2-plus.tar.gz
           tar -xzf apache-tomee-1.6.0.2-plus.tar.gz
           mv /usr/share/tomcat7 /usr/share/tomcat
       	   mv apache-tomee-1.6.0.2-plus.tar.gz /usr/share/tomcat7
	   chown -R tomcat7:tomcat7 /usr/share/tomcat7
     EOH
     not_if "test -d /usr/share/tomee"
end

template "/etc/init.d/tomee" do
	source "tomee_initd.erb"
	mode 0755
	owner "root"
	owner "root"
end
# stop tomcat7 service
service 'tomee' do
  action :start
end
