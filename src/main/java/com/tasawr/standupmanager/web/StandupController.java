package com.tasawr.standupmanager.web;

import com.tasawr.standupmanager.domain.Employee;
import com.tasawr.standupmanager.domain.Standup;
import java.io.UnsupportedEncodingException;
import java.security.Principal;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.joda.time.format.DateTimeFormat;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.roo.addon.web.mvc.controller.finder.RooWebFinder;
import org.springframework.roo.addon.web.mvc.controller.scaffold.RooWebScaffold;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

@RequestMapping("/standups")
@Controller
@RooWebScaffold(path = "standups", formBackingObject = Standup.class)
@RooWebFinder
public class StandupController {

    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String create(@Valid Standup standup, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest, Principal principal, Employee employee) {
        if (bindingResult.hasErrors()) {
        	
            populateEditForm(uiModel, standup);
            return "standups/create";
        }
        
        
        uiModel.asMap().clear();
        
        
        String name = SecurityContextHolder.getContext().getAuthentication().getName();
        
        
        Employee empByName = (Employee) Employee.findEmployeesByNameEquals(name).getSingleResult();
        
           standup.setConductor(empByName);
  
            standup.persist();	
	
        
        return "redirect:/standups/" + encodeUrlPathSegment(standup.getId().toString(), httpServletRequest);
    }

    @RequestMapping(params = "form", produces = "text/html")
    public String createForm(Model uiModel) {
        populateEditForm(uiModel, new Standup());
        return "standups/create";
    }

    @RequestMapping(value = "/{id}", produces = "text/html")
    public String show(@PathVariable("id") Long id, Model uiModel) {
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("standup", Standup.findStandup(id));
        uiModel.addAttribute("itemId", id);
        return "standups/show";
    }

    @RequestMapping(produces = "text/html")
    public String list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("standups", Standup.findStandupEntries(firstResult, sizeNo));
            float nrOfPages = (float) Standup.countStandups() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("standups", Standup.findAllStandups());
        }
        addDateTimeFormatPatterns(uiModel);
        return "standups/list";
    }

    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String update(@Valid Standup standup, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, standup);
            return "standups/update";
        }
        uiModel.asMap().clear();
        standup.merge();
        return "redirect:/standups/" + encodeUrlPathSegment(standup.getId().toString(), httpServletRequest);
    }

    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Standup.findStandup(id));
        return "standups/update";
    }

    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Standup standup = Standup.findStandup(id);
        standup.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/standups";
    }

    void addDateTimeFormatPatterns(Model uiModel) {
        uiModel.addAttribute("standup_standup_date_date_format", DateTimeFormat.patternForStyle("M-", LocaleContextHolder.getLocale()));
    }

    void populateEditForm(Model uiModel, Standup standup) {
        uiModel.addAttribute("standup", standup);
        addDateTimeFormatPatterns(uiModel);
        uiModel.addAttribute("employees", Employee.findAllEmployees());
    }

    String encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {
        }
        return pathSegment;
    }
}
