package www.test.com.test.control;

import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/test/*")
public class TestController {
	private static PythonInterpreter intPre;
	
	@GetMapping(value="python")
	public String getTest(Model model) {
		System.setProperty("python.import.site", "false");
		intPre = new PythonInterpreter();
		intPre.execfile("test.py");
		intPre.exec("print(testFunc(5,10))");

		PyFunction pyFunction =  (PyFunction) intPre.get("testFunc", PyFunction.class);
		int a= 10;
		int b= 20;
		PyObject pyobj = pyFunction.__call__(new PyInteger(a), new PyInteger(b));
		model.addAttribute("pyobj", pyobj.toString());
		System.out.println(pyobj.toString());
		return "test/python";
	}
}
