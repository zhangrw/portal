package com.banshion.portal.web.sys.filter;

import com.banshion.portal.util.domain.BaseFilter;

/**
 * Created by zhang.rw on 16-4-21.
 */
public class RoleFilter extends BaseFilter
{
    String roleName;

    public String getRoleName()
    {
        return roleName;
    }

    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }
}
