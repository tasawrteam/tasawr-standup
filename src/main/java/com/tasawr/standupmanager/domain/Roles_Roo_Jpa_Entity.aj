// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tasawr.standupmanager.domain;

import com.tasawr.standupmanager.domain.Roles;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Version;

privileged aspect Roles_Roo_Jpa_Entity {
    
    declare @type: Roles: @Entity;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name = "id")
    private Long Roles.id;
    
    @Version
    @Column(name = "version")
    private Integer Roles.version;
    
    public Long Roles.getId() {
        return this.id;
    }
    
    public void Roles.setId(Long id) {
        this.id = id;
    }
    
    public Integer Roles.getVersion() {
        return this.version;
    }
    
    public void Roles.setVersion(Integer version) {
        this.version = version;
    }
    
}
