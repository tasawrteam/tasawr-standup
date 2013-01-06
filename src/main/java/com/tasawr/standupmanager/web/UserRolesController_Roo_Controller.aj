// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tasawr.standupmanager.web;

import com.tasawr.standupmanager.domain.UserRoles;
import com.tasawr.standupmanager.web.UserRolesController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect UserRolesController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String UserRolesController.create(@Valid UserRoles userRoles, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, userRoles);
            return "userroleses/create";
        }
        uiModel.asMap().clear();
        userRoles.persist();
        return "redirect:/userroleses/" + encodeUrlPathSegment(userRoles.getRoleId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String UserRolesController.createForm(Model uiModel) {
        populateEditForm(uiModel, new UserRoles());
        return "userroleses/create";
    }
    
    @RequestMapping(value = "/{roleId}", produces = "text/html")
    public String UserRolesController.show(@PathVariable("roleId") Integer roleId, Model uiModel) {
        uiModel.addAttribute("userroles", UserRoles.findUserRoles(roleId));
        uiModel.addAttribute("itemId", roleId);
        return "userroleses/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String UserRolesController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("userroleses", UserRoles.findUserRolesEntries(firstResult, sizeNo));
            float nrOfPages = (float) UserRoles.countUserRoleses() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("userroleses", UserRoles.findAllUserRoleses());
        }
        return "userroleses/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String UserRolesController.update(@Valid UserRoles userRoles, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, userRoles);
            return "userroleses/update";
        }
        uiModel.asMap().clear();
        userRoles.merge();
        return "redirect:/userroleses/" + encodeUrlPathSegment(userRoles.getRoleId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{roleId}", params = "form", produces = "text/html")
    public String UserRolesController.updateForm(@PathVariable("roleId") Integer roleId, Model uiModel) {
        populateEditForm(uiModel, UserRoles.findUserRoles(roleId));
        return "userroleses/update";
    }
    
    @RequestMapping(value = "/{roleId}", method = RequestMethod.DELETE, produces = "text/html")
    public String UserRolesController.delete(@PathVariable("roleId") Integer roleId, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        UserRoles userRoles = UserRoles.findUserRoles(roleId);
        userRoles.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/userroleses";
    }
    
    void UserRolesController.populateEditForm(Model uiModel, UserRoles userRoles) {
        uiModel.addAttribute("userRoles", userRoles);
    }
    
    String UserRolesController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}