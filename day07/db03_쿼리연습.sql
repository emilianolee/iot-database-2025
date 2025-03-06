-- WorkBook : SQL Practice
/* 샘플 - Employee에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력하시오.
		이때 이름과 성을 연결하여 Full Name이라는 별칭으로 출력하시오 (107)행
*/
select employee_id
	 , concat(first_name, ' ', last_name) as 'full name'
     , salary
     , job_id
     , hire_date
     , manager_id
  from employees;
  
/* 문제1 - employee에서 사원의 성과 이름을 Name, 업무는 Job, 급여는 Salary, 연봉에 $100 보너스를 추가해서 계산한 Increased ann_Salary
			급여에 $100 보너스를 추가해서 Increased Salary 별칭으로 출력하시오.(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , job_id as Job
     , salary as Salary
     , (salary*12) + 100 as 'Increased ann_Salary'
     , (salary + 100) * 12 as 'Increased Annual'
  from employees;
  
/* 문제2 - Employees 에서 모든 사원의 last_name과 연봉을 '이름: 1 Year Salary = $연봉' 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오.(107행)
*/
select concat(last_name, ': 1 Year Salary = $', (salary * 12)) as '1 Year Salary'
  from employees;
  
/* 문제3 - 부서에 담당하는 업무를 한번씩만 출력하시오.(20행)*/
select DISTINCT department_id, job_id
  from employees;
  
-- where, order by
/* 샘플 - hr부서 예산 편성 문제로 급여 정보 보고서를 작성한다. employees에서 salary가 7000 ~ 10000달러 범위 이외의 사람의
		성과 이름을 Name해서 급여를 급여가 작은 순서로 출력하시오.(75행)
*/

select concat(first_name, ' ', last_name) as 'Name'
	 , salary
  from employees
 where salary not between 7000 and 10000
 order by salary asc;

/* 문제1 - 사원의 last_name 중 e 및 o 글자를 포함한 사원을 출력하시오. 이때 컬럼명은 e And o Name 이라고 출력하시오.(10행)  
*/
select last_name as 'e And o Name' 
  from employees
 where last_name like '%e%' and last_name like '%o%';
 
/* 문제2 - 현재 날짜 타입을 날짜함수를 통해 확인, 1995년 5월 20일 ~ 1996년 5월 20일 사이 입사한 사원의 이름 Name으로 별칭
			사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오.(8행)
*/
select date_add(sysdate(), interval 9 hour) as 'sysdate()';

select last_name as Name
	 , employee_id
     , hire_date
  from employees
 where hire_date between '1995-05-20' and '1996-05-20' -- date 타입은 문자열처럼 조건연산을 해도 됨
 order by hire_date;
 
-- 단일행 함수 및 변환 함수ALTER
/*문제 1 - 이름이 s로 시작하는 각 사원의 업무를 아래의 예와 같이 출력하고 함.(18행)
		머리글은 Employee JOBs.로 표시할 것
*/

select concat(first_name, ' ', last_name, ' is a ', upper(job_id)) as 'Employee JOBs.'
  from employees
 where last_name like '%s';
 
/* 문제 3 - 사원의 성과 이름을 Name으로 별칭, 입사일, 입사한 요일을 출력하시오. 이때 주(week) 시작인 일요일부터 출력되도록 정렬(107행)
*/
select concat(first_name, ' ', last_name) as 'Name'
	 , hire_date
     , date_format(hire_date, '%W') as 'Day of the week'
  from employees
 ORDER BY date_format(hire_date, '%w') asc, hire_date;

-- 집계함수
/* 문제1 - 사원이 소속된 부서별 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계.
		  출력 값은 여섯자리와 세자리 구분기호, $표시 포함, 부서번호를 오름차순
		  단, 부서에 소속된 않는 사원은 정보에서 제외, 출력시 머리글은 아래처럼 별칭으로 처리(11행)
*/
select department_id
	 , concat('$', format(round(SUM(salary), 0), 0)) as 'Sum Salary'
     , concat('$', format(round(AVG(salary), 0), 1)) as 'Avg Salary' -- round(값, 1) 소수점 1자리에서 반올림, format(값, 1) 소수점 표현 및 1000단위 , 표시
     , concat('$', format(round(MAX(salary), 0), 0)) as 'Max Salary'
     , concat('$', format(round(MIN(salary), 0), 0)) as 'Min Salary'
  from employees
 WHERE department_id is not null
 GROUP BY department_id; -- group by 속한 컬럼만 select 절에 사용할 수 있음
 
-- 조인
/* 문제2 - job_grades 테이블을 사용, 각 사원의 급여에 따른 급여등급을 보고한다. 이름과 성을 name으로, 업무, 부서명, 입사일, 급여, 급여등급을 출력(106행)
*/
desc job_grades;
desc employees;

select *
  from departments as d inner join employees as e
    on d.department_id = e.department_id; -- ANSI Standard SQL 쿼리

select concat(e.first_name, ' ', e.last_name) as name
	 , e.job_id
     , d.department_name
     , e.hire_date
     , e.salary
     , (select grade_level from job_grades
		 where e.salary between lowest_sal and highest_sal) as 'grade_level' -- 서브쿼리 추가!!
  from departments as d, employees as e
 where d.department_id = e.department_id
 order by e.salary desc;

-- 서브쿼리 테스트
select *
  from job_grades
 where 2200 between lowest_sal and highest_sal;

/* 문제3 - 각 사원의 상사와의 관계를 이용, 보고서 작성을 하려고 함
			예를 보고 출력하시오(107개 행)
*/
select concat(e2.first_name, ' ', e2.last_name) as 'Employee'
	 , 'report to'
     , upper(concat(e1.first_name, ' ', e1.last_name)) as 'Manager'
  from employees as e1 right join employees as e2
    on e1.employee_id = e2.manager_id;
    
-- 서브쿼리
/* 문제3 - 사원들의 지역별 근무현황을 조회. 도시 이름이 영문'O'로 시작하는 지역에 살고
			사번, 이름, 업무, 입사일을 출력하시오(34행)
*/
select e.employee_id
	 , concat(e.first_name, ' ', e.last_name) as 'name'
     , e.job_id
     , e.hire_date
  from employees as e, departments as d
 where e.department_id = d.department_id
   and d.location_id = (select location_id
						  from locations
						 where city like 'O%');

-- 서브쿼리 테스트
select location_id
  from locations
 where city like 'O%';