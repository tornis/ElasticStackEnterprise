select 
	e.emp_no,
	DATE_FORMAT(e.hire_date, '%Y-%m-%d') as hire_date,
	DATE_FORMAT(e.birth_date, '%Y-%m-%d') as birth_date,
	e.first_name,
	e.last_name,
	concat(e.first_name, ' ',  e.last_name) as full_name,
	e.gender,
	s.salary,
	DATE_FORMAT(s.from_date, '%Y-%m-%d') as from_date,
	DATE_FORMAT(s.to_date, '%Y-%m-%d') as to_date,
	t.title,
	dpm.dept_name as manager_department,
	dpe.dept_name as employee_department
from employees e
join salaries s on s.emp_no = e.emp_no
join titles t on t.emp_no = e.emp_no
left join dept_manager dm on dm.emp_no = e.emp_no
left join departments dpm on dpm.dept_no = dm.dept_no
left join dept_emp de on de.emp_no = e.emp_no
left join departments dpe on dpe.dept_no = de.dept_no
