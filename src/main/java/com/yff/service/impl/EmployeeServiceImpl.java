package com.yff.service.impl;

import com.yff.dao.EmployeeMapper;
import com.yff.entity.Employee;
import com.yff.entity.EmployeeCustom;
import com.yff.entity.EmployeeExample;
import com.yff.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements EmployeeService{

    @Autowired
    private EmployeeMapper employeeMapper;


    @Override
    public List<EmployeeCustom> getEmployeeList() {
        EmployeeExample employeeExample = new EmployeeExample();
        List<EmployeeCustom> employeeCustoms = employeeMapper.selectByExampleWithDept(employeeExample);
        return employeeCustoms;
    }

    @Override
    public void saveEmployee(Employee employee) {
        employeeMapper.insertSelective(employee);
    }
}
