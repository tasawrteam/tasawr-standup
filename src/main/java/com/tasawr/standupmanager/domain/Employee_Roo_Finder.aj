// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tasawr.standupmanager.domain;

import com.tasawr.standupmanager.domain.Employee;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;

privileged aspect Employee_Roo_Finder {
    
    public static TypedQuery<Employee> Employee.findEmployeesByNameEquals(String name) {
        if (name == null || name.length() == 0) throw new IllegalArgumentException("The name argument is required");
        EntityManager em = Employee.entityManager();
        TypedQuery<Employee> q = em.createQuery("SELECT o FROM Employee AS o WHERE o.name = :name", Employee.class);
        q.setParameter("name", name);
        return q;
    }
    
    public static TypedQuery<Employee> Employee.findEmployeesByNameIsNull() {
        EntityManager em = Employee.entityManager();
        TypedQuery<Employee> q = em.createQuery("SELECT o FROM Employee AS o WHERE o.name IS NULL", Employee.class);
        return q;
    }
    
}