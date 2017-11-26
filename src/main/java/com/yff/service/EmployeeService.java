package com.yff.service;

import com.yff.entity.Employee;
import com.yff.entity.EmployeeCustom;

import java.util.List;

public interface EmployeeService {
    /**
     * 查询员工信息列表
     * @return
     */
    List<EmployeeCustom> getEmployeeList();

    void saveEmployee(Employee employee);
}
