<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:jgroups="urn:jboss:domain:jgroups:4.0">

	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="//jgroups:subsystem">
		<subsystem xmlns="urn:jboss:domain:jgroups:4.0">
			<channels default="ee">
				<channel name="ee" stack="tcp"/>
			</channels>
			<stacks default="tcp">
				<stack name="tcp">
					<transport type="TCP" socket-binding="jgroups-tcp"/>
					<protocol type="JDBC_PING">
						<property name="datasource_jndi_name">
							java:jboss/datasources/KeycloakDS
						</property>
						<property name="initialize_sql">
							CREATE TABLE IF NOT EXISTS JGROUPSPING (
							own_addr varchar(200) NOT NULL,
							cluster_name varchar(200) NOT NULL,
							ping_data bytea DEFAULT NULL,
							PRIMARY KEY (own_addr, cluster_name))
						</property>
					</protocol>
					<protocol type="MERGE3"/>
					<protocol type="FD_SOCK" socket-binding="jgroups-tcp-fd"/>
					<protocol type="FD"/>
					<protocol type="VERIFY_SUSPECT"/>
					<protocol type="pbcast.NAKACK2">
						<property name="use_mcast_xmit">
							false
						</property>
					</protocol>
					<protocol type="UNICAST3">
						<property name="conn_close_timeout">
							5000
						</property>
					</protocol>
					<protocol type="pbcast.STABLE"/>
					<protocol type="pbcast.GMS">
						<property name="join_timeout">
							10000
						</property>
					</protocol>
					<protocol type="MFC"/>
					<protocol type="FRAG2"/>
				</stack>
			</stacks>
		</subsystem>
	</xsl:template>

	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>

