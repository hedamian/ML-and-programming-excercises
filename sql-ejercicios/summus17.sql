--select * from Empleado where empleadoid=1062

--select * from EmpleadoEscolaridad where empleadoid=1062

--select * from EmpleadoFamilia where empleadoid=1062

--select e.empleadoid as numero, f.empleadofamilianombrecompleto from EmpleadoFamilia as f
--join EmpleadoEscolaridad as e on e.EmpleadoId=f.EmpleadoId where e.empleadoid=1062



--select * from EmpleadoTelefono where EmpleadoId=203

--select * from Empleado where empleadoid=203

--select EmpleadoEmail from EmpleadoEmail where empleadoid=1062


--select * from EmpleadoEscolaridad where empleadoid=203


--delete from EmpleadoTelefono where empleadoid=203 and EmpleadoTelefonoId in (145,146)

--select * from EmpleadoTelefono where EmpleadoId=203

--select * from Empleado
--order by EmpleadoExpediente

SELECT * from Empleado where EmpleadoExpediente=7467



SELECT * from Empleado where empleadoid=1062

SELECT * from EmpleadoEmail where empleadoid=6686

