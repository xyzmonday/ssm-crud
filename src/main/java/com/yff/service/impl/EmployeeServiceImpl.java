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


    @Override
    public boolean findByEmpName(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    @Override
    public EmployeeCustom findEmp(Integer empId) {
        if(empId == null) {
            return null;
        }
        EmployeeCustom employeeCustom = employeeMapper.selectByPrimaryKeyWithDept(empId);
        return employeeCustom;
    }

    @Override
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    @Override
    public void deleteEmp(Integer empId) {
        employeeMapper.deleteByPrimaryKey(empId);
    }

    @Override
    public void deleteBatch(List<Integer> empIds) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpIdIn(empIds);
        employeeMapper.deleteByExample(employeeExample);
    }
}
