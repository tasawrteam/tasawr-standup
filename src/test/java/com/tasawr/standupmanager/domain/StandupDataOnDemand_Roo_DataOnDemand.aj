// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package com.tasawr.standupmanager.domain;

import com.tasawr.standupmanager.domain.EmployeeDataOnDemand;
import com.tasawr.standupmanager.domain.Standup;
import com.tasawr.standupmanager.domain.StandupDataOnDemand;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect StandupDataOnDemand_Roo_DataOnDemand {
    
    declare @type: StandupDataOnDemand: @Component;
    
    private Random StandupDataOnDemand.rnd = new SecureRandom();
    
    private List<Standup> StandupDataOnDemand.data;
    
    @Autowired
    EmployeeDataOnDemand StandupDataOnDemand.employeeDataOnDemand;
    
    public Standup StandupDataOnDemand.getNewTransientStandup(int index) {
        Standup obj = new Standup();
        setBlocker(obj, index);
        setPrevious_work(obj, index);
        setStandup_date(obj, index);
        setTodays_work(obj, index);
        return obj;
    }
    
    public void StandupDataOnDemand.setBlocker(Standup obj, int index) {
        String blocker = "blocker_" + index;
        if (blocker.length() > 500) {
            blocker = blocker.substring(0, 500);
        }
        obj.setBlocker(blocker);
    }
    
    public void StandupDataOnDemand.setPrevious_work(Standup obj, int index) {
        String previous_work = "previous_work_" + index;
        if (previous_work.length() > 500) {
            previous_work = previous_work.substring(0, 500);
        }
        obj.setPrevious_work(previous_work);
    }
    
    public void StandupDataOnDemand.setStandup_date(Standup obj, int index) {
        Date standup_date = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setStandup_date(standup_date);
    }
    
    public void StandupDataOnDemand.setTodays_work(Standup obj, int index) {
        String todays_work = "todays_work_" + index;
        if (todays_work.length() > 500) {
            todays_work = todays_work.substring(0, 500);
        }
        obj.setTodays_work(todays_work);
    }
    
    public Standup StandupDataOnDemand.getSpecificStandup(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Standup obj = data.get(index);
        Long id = obj.getId();
        return Standup.findStandup(id);
    }
    
    public Standup StandupDataOnDemand.getRandomStandup() {
        init();
        Standup obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return Standup.findStandup(id);
    }
    
    public boolean StandupDataOnDemand.modifyStandup(Standup obj) {
        return false;
    }
    
    public void StandupDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = Standup.findStandupEntries(from, to);
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Standup' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Standup>();
        for (int i = 0; i < 10; i++) {
            Standup obj = getNewTransientStandup(i);
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