package com.yff.test;

import com.yff.dao.DepartmentMapper;
import com.yff.dao.EmployeeMapper;
import com.yff.entity.Department;
import com.yff.entity.Employee;
import com.yff.entity.EmployeeCustom;
import com.yff.entity.EmployeeExample;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext-*.xml")
public class EmployeeTest {

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private DepartmentMapper departmentMapper;

    @Test
    public void test1() {
        EmployeeExample employeeExample = new EmployeeExample();
        List<EmployeeCustom> employees = employeeMapper.selectByExampleWithDept(employeeExample);
        System.out.println(employees.get(0).getEmpName());
        System.out.println(employees.get(0).getDepartment().getDeptName());
    }

    @Test
    public void test2() {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeCustom employee = employeeMapper.selectByPrimaryKeyWithDept(2);
        System.out.println(employee.getEmpName());
        System.out.println(employee.getDepartment().getDeptName());
    }


    @Test
    public void test3() {
        //插入部门
        Department department1 = new Department();
        department1.setDeptName("财务部");
        Department department2 = new Department();
        department2.setDeptName("人事部");
        departmentMapper.insertSelective(department1);
        departmentMapper.insertSelective(department2);

        //生成员工
        for (int i = 0; i < 100; i++) {
            Employee employee = new Employee();
            employee.setDeptId(i % 2 == 0 ? 1 : 2);
            employee.setEmail("#" + i + "@163.com");
            employee.setEmpName("No#" + i);
            employee.setGender(i % 2 == 0 ? "男" : "女");
            employeeMapper.insertSelective(employee);
        }
    }
}
