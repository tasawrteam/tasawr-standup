// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tasawr.standupmanager.domain;

import com.tasawr.standupmanager.domain.Employee;
import com.tasawr.standupmanager.domain.EmployeeDataOnDemand;
import com.tasawr.standupmanager.domain.UserRoles;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.stereotype.Component;

privileged aspect EmployeeDataOnDemand_Roo_DataOnDemand {
    
    declare @type: EmployeeDataOnDemand: @Component;
    
    private Random EmployeeDataOnDemand.rnd = new SecureRandom();
    
    private List<Employee> EmployeeDataOnDemand.data;
    
    public Employee EmployeeDataOnDemand.getNewTransientEmployee(int index) {
        Employee obj = new Employee();
        setAddress(obj, index);
        setDesignation(obj, index);
        setEmail(obj, index);
        setEnabled(obj, index);
        setName(obj, index);
        setPassword(obj, index);
        setUser_role(obj, index);
        setUsername(obj, index);
        return obj;
    }
    
    public void EmployeeDataOnDemand.setAddress(Employee obj, int index) {
        String address = "address_" + index;
        if (address.length() > 100) {
            address = address.substring(0, 100);
        }
        obj.setAddress(address);
    }
    
    public void EmployeeDataOnDemand.setDesignation(Employee obj, int index) {
        String designation = "designation_" + index;
        if (designation.length() > 50) {
            designation = designation.substring(0, 50);
        }
        obj.setDesignation(designation);
    }
    
    public void EmployeeDataOnDemand.setEmail(Employee obj, int index) {
        String email = "foo" + index + "@bar.com";
        if (email.length() > 50) {
            email = email.substring(0, 50);
        }
        obj.setEmail(email);
    }
    
    public void EmployeeDataOnDemand.setEnabled(Employee obj, int index) {
        Boolean enabled = Boolean.TRUE;
        obj.setEnabled(enabled);
    }
    
    public void EmployeeDataOnDemand.setName(Employee obj, int index) {
        String name = "name_" + index;
        if (name.length() > 50) {
            name = name.substring(0, 50);
        }
        obj.setName(name);
    }
    
    public void EmployeeDataOnDemand.setPassword(Employee obj, int index) {
        String password = "password_" + index;
        if (password.length() > 10) {
            password = password.substring(0, 10);
        }
        obj.setPassword(password);
    }
    
    public void EmployeeDataOnDemand.setUser_role(Employee obj, int index) {
        UserRoles user_role = null;
        obj.setUser_role(user_role);
    }
    
    public void EmployeeDataOnDemand.setUsername(Employee obj, int index) {
        String username = "username_" + index;
        if (username.length() > 10) {
            username = new Random().nextInt(10) + username.substring(1, 10);
        }
        obj.setUsername(username);
    }
    
    public Employee EmployeeDataOnDemand.getSpecificEmployee(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Employee obj = data.get(index);
        Long id = obj.getId();
        return Employee.findEmployee(id);
    }
    
    public Employee EmployeeDataOnDemand.getRandomEmployee() {
        init();
        Employee obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Employee.findEmployee(id);
    }
    
    public boolean EmployeeDataOnDemand.modifyEmployee(Employee obj) {
        return false;
    }
    
    public void EmployeeDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Employee.findEmployeeEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Employee' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Employee>();
        for (int i = 0; i < 10; i++) {
            Employee obj = getNewTransientEmployee(i);
            try {
                obj.persist();
            } catch (ConstraintViolationException e) {
                StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getConstraintDescriptor()).append(":").append(cv.getMessage()).append("=").append(cv.getInvalidValue()).append("]");
                }
                throw new RuntimeException(msg.toString(), e);
            }
            obj.flush();
            data.add(obj);
        }
    }
    
}
