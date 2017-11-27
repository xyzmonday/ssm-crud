package com.yff.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yff.dao.EmployeeMapper;
import com.yff.entity.Employee;
import com.yff.entity.EmployeeCustom;
import com.yff.entity.Msg;
import com.yff.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * /emp/{id} get 查询
 * /emp post 保存
 * /emp/{id} put 修改
 * /emp/{id} delete 删除
 */
@RestController
@RequestMapping("/emp")
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    @GetMapping("/list")
    public Msg getAllEmployees(@RequestParam(value = "pageNum", required = false,
            defaultValue = "1") Integer pageNum) {
        PageHelper.startPage(pageNum, 5);
        List<EmployeeCustom> employeeList = employeeService.getEmployeeList();
        PageInfo<EmployeeCustom> pageInfo = new PageInfo<>(employeeList, 5);
        return Msg.success().put("pageInfo", pageInfo);
    }

    @PostMapping("/save")
    public Msg saveEmployee(@Valid Employee employee, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            Map<String, Object> errorMap = new HashMap<>();
            List<FieldError> fieldErrors = bindingResult.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                errorMap.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().put("errorFields", errorMap);
        }
        employeeService.saveEmployee(employee);
        return Msg.success();
    }


    @GetMapping("/checkUser")
    public Msg checkUser(String empName) {
        //先判断用户名是否是合法的表达式
        String empNameReg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (empName == null) {
            return Msg.fail();
        }
        if (!empName.matches(empNameReg)) {
            return Msg.fail().put("msg_emp_name_validate", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
        }
        //数据库重复校验
        boolean flag = employeeService.findByEmpName(empName);
        if (flag) {
            return Msg.success();
        } else {
            return Msg.fail().put("msg_emp_name_validate", "用户名不可用");
        }
    }

    @GetMapping("/{empId}")
    public Msg getEmp(@PathVariable("empId") Integer empId) {
        EmployeeCustom employeeCustom = employeeService.findEmp(empId);
        if (employeeCustom == null) {
            return Msg.fail();
        }
        return Msg.success().put("emp", employeeCustom);
    }

    /**
     * 员工更新，注意在web.xml加入HiddenHttpMethodFilter，HttpPutFormContentFilter
     * 过滤器。
     * 补充:Tomcat->HttpServletRequest->SpringMVC的赋值过程
     * 1、tomcat将请求体中的数据，封装一个map。
     * 2、request.getParameter("empName")就会从这个map中取值。
     * 3、SpringMVC封装POJO对象的时候。会把POJO中每个属性的值，request.getParamter("email");
     * 那么tomcat不会将put请求中的数据封装为map。
     * HttpPutFormContentFilter过滤器重写了getParameter方法
     * @param employee
     * @return
     */
    @PutMapping(value = "/{empId}")
    public Msg updateEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @DeleteMapping("/{empIds}")
    public Msg deleteEmp(@PathVariable("empIds") String empIds) {
        if(empIds.contains("-")) {
            String[] split = empIds.split("-");
            List<Integer> idList = new ArrayList<>();
            for (String empId : split) {
                idList.add(Integer.parseInt(empId));
            }
            employeeService.deleteBatch(idList);
        } else {
            Integer empId = Integer.parseInt(empIds);
            employeeService.deleteEmp(empId);
        }

        return Msg.success();
    }

}
