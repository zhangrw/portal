package com.banshion.portal.sys.authentication;

import java.io.Serializable;
import java.util.List;

/**
 * 
 * 功能说明：自定义Authentication对象，使得Subject除了携带用户的登录名外还可以携带更多信息
 */
@SuppressWarnings("serial")
public class ShiroUser implements Serializable {

	private String id;// UserId
	private String loginname;// loginName
	private String name;// name
	private boolean isAdmin;// 是否系统级管理员
	private String organId;           //人员对应的组织ID
	private String departmentId;      //所属部门ID
	private String companyId;         //所属公司ID
	private String current_projectId; //当前项目ID
	private String lccCode; //单位ID
	private String IP;
	private boolean isOrganAdmin;
	private String icon;//用户图标
	private List<String> roleIdList;   

	public ShiroUser(String id, String loginname, String name, Boolean isAdmin,
					 String organId, String clientIp, Boolean isOrganAdmin,
					 List<String> roleIdList, String projectId, String lccCode, String projectName, String lccName, String icon) {
		this.id = id;
		this.loginname = loginname;
		this.name = name;
		this.organId = organId;
		this.IP = clientIp;
		this.isAdmin = isAdmin;
		this.isOrganAdmin = isOrganAdmin;
		this.roleIdList = roleIdList;
		this.current_projectId = projectId;
		this.lccCode = lccCode;
		this.icon=icon;
	}
	
	public ShiroUser(String id, String loginName, String name, Boolean isAdmin,
					 String organId, String clientIp, Boolean isOrganAdmin,
					 List<String> roleIdList, String projectId, String lccCode, String projectName, String lccName) {
      this.id = id;
      this.loginname = loginName;
      this.name = name;
      this.organId = organId;
      this.IP = clientIp;
      this.isAdmin = isAdmin;
      this.isOrganAdmin = isOrganAdmin;
      this.roleIdList = roleIdList;
      this.current_projectId = projectId;
      this.lccCode = lccCode;
      this.icon=icon;
   }
	
	public ShiroUser(String id, String loginname, String name, Boolean isAdmin, String clientIp){
		this.id = id;
		this.loginname = loginname;
		this.name = name;
		this.IP = clientIp;
		this.isAdmin = isAdmin;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	} 

	public String getDepartmentId() {
		return departmentId;
	}

	private void setDepartmentId(String departmentId) {
		this.departmentId = departmentId;
	}

	public String getCompanyId() {
		return companyId;
	}

	private void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	public String getCurrent_projectId() {
		return current_projectId;
	}

	public void setCurrent_projectId(String current_projectId) {
		this.current_projectId = current_projectId;
	} 

	public String getLoginName() {
		return loginname;
	}

	public void setLoginName(String loginname) {
		this.loginname = loginname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isAdmin() {
		return isAdmin;
	}

	public void setAdmin(boolean isAdmin) {
		this.isAdmin = isAdmin;
	}

	public List<String> getRoleIdList() {
		return roleIdList;
	}

	public void setRoleIdList(List<String> roleIdList) {
		this.roleIdList = roleIdList;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result
				+ ((loginname == null) ? 0 : loginname.hashCode());
		result = prime * result
				+ ((organId == null) ? 0 : organId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ShiroUser other = (ShiroUser) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (loginname == null) {
			if (other.loginname != null)
				return false;
		} else if (!loginname.equals(other.loginname))
			return false;
		if (organId == null) {
			if (other.organId != null)
				return false;
		} else if (!organId.equals(other.organId))
			return false;
		return true;
	}

	public String getOrganId() {
		return organId;
	}

	public void setOrganId(String organId) {
		this.organId = organId;
	}

	public String getIP() {
		return IP;
	}

	public void setIP(String iP) {
		IP = iP;
	}

	public boolean isOrganAdmin() {
		return isOrganAdmin;
	}

	public void setOrganAdmin(boolean isOrganAdmin) {
		this.isOrganAdmin = isOrganAdmin;
	}

	@Override
	public String toString() {
		return "ShiroUser [id=" + id + ", loginname=" + loginname + ", name="
				+ name + ", isAdmin=" + isAdmin + ", tenantId=" + organId
				+ ", IP=" + IP + ", isOrganAdmin=" + isOrganAdmin + "]";
	}

	public String getLccCode() {
		return lccCode;
	}

	public void setLccCode(String lccCode) {
		this.lccCode = lccCode;
	}

   public String getIcon() {
      return icon;
   }

   public void setIcon(String icon) {
      this.icon = icon;
   }
}
