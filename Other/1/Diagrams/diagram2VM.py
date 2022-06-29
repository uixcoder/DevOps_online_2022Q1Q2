from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EC2
from diagrams.aws.network import ELB
from diagrams.generic.os import Centos
from diagrams.generic.os import Ubuntu
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.ci import Jenkins
from diagrams.onprem.iac import Terraform
from diagrams.onprem.iac import Ansible
from diagrams.onprem.vcs import Github
from diagrams.onprem.compute import Server
from diagrams.onprem.network import Tomcat
from diagrams.generic.blank import Blank
from diagrams.oci.compute import Functions
from diagrams.onprem.client import User
from diagrams.programming.language import Java
from diagrams.custom import Custom

with Diagram("Geocitizen Application manual Deploy on 2 VMs", show=False):
    with Cluster("x86/x64 PC"):
        pc = Custom("", "./img/pc1.gif")
        os_mint = Custom("", "./img/mint.png")
        with Cluster("VirtualBox"):
            vbox = Custom("", "./img/virtualbox.png")
            with Cluster("Apache Tomcat Server"):
                vm_ubuntu = Custom("VM 1", "./img/virtualbox.png")
                os_ubuntu = Ubuntu()
                tomcat = Tomcat("Apache Tomcat Server")
                jav = Java("")
                mvn = Custom("", "./img/maven.png")
                # deploy = Functions("Application deploy script")
                geoapp = Custom("Geocitizen", "./img/geo.png")
            with Cluster("PostgreSQL Database Server"):
                vm_centos = Custom("VM 2", "./img/virtualbox.png")
                os_centos = Centos()
                database = PostgreSQL("Database")
    repo = Github("Application repository")

    pc >> os_mint >> vbox >> [vm_ubuntu, vm_centos]
    os_ubuntu >> [jav, tomcat, mvn]
    repo >> mvn >> geoapp >> tomcat >> database
    os_centos >> database
    vm_ubuntu >> os_ubuntu
    vm_centos >> os_centos

    # Dev >> Edge(color="green", style="bold") >> Jen
    # Jen >> Edge(color="red", style="bold",
    #             label="Step 1.") >> Terra
    # Jen >> Edge(color="red", style="bold",
    #             label="Step 2.") >> Ansi
    # Terra >> Edge(color="black", style="bold") >> vm_ubuntu >> Edge(
    #     color="black", style="bold") >> os_ubuntu
    # Terra >> Edge(color="black", style="bold") >> vm_centos >> Edge(
    #     color="black", style="bold") >> os_centos
    # os_ubuntu >> Edge(color="brown", style="bold", label="") >> jav
    # os_ubuntu >> Edge(color="brown", style="bold", label="") >> tomcat
    # os_ubuntu >> Edge(color="brown", style="bold", label="") >> mvn
    # os_ubuntu >> Edge(color="brown", style="bold", label="") >> mvn
    # repo >> Edge(color="black", style="bold")
    # Ansi >> Edge(color="black", style="bold") >> [os_ubuntu, os_centos]
    # mvn >> Edge(color="black", style="bold") >> geoapp >> Edge(
    #     color="black", style="bold") >> tomcat
    # os_centos >> Edge(color="black", style="bold") >> database
    # tomcat >> Edge(color="black", style="bold") >> database
    # repo >> Edge(color="black", style="bold") >> mvn

    # Jen >> Edge(color="red", style="bold", label="Step 1. Set VM with OS installed") >> Terra >> \
    #     [vm_ubuntu >> os_ubuntu, vm_centos >> os_centos]
    # Jen >> Edge(color="red", style="bold", label="Step 2. Configure VMs") >> Ansi >>\
    #     [os_ubuntu >> tomcat, os_ubuntu >> mvn,
    #         os_ubuntu >> jav, os_centos >> database]
    # Jen >> Edge(color="red", style="bold", label="Step 3. Deploy Application") >> deploy >> \
    #     mvn >> [database, tomcat]

    # repo >> deploy
    # tomcat << geoapp
