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

    /**
     * 保存新增员工
     * @param employee
     */
    void saveEmployee(Employee employee);

    /**
     * 检验员工名是否可用
     * @param empName
     * @return true表示当前姓名可用，false表示当前姓名不可用
     */
    boolean findByEmpName(String empName);

    /**
     * 通过员工id查询员工信息以及部门信息
     * @param empId
     * @return
     */
    EmployeeCustom findEmp(Integer empId);

    void updateEmp(Employee employee);

    void deleteEmp(Integer empId);

    void deleteBatch(List<Integer> empIds);
}
