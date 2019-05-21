package com.model2.mvc.web.user;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {

	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 안함

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;


	public UserRestController(){
		System.out.println(this.getClass());
	}

	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET ) //강사님
	public User getUser( @PathVariable String userId ) throws Exception{

		System.out.println("/user/json/getUser : GET");

		//Business Logic
		return userService.getUser(userId);
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST ) //강사님
	public User login(	@RequestBody User user,
			HttpSession session ) throws Exception{

		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());

		if( user.getPassword().equals(dbUser.getPassword())){
			session.setAttribute("user", dbUser);
		}

		return dbUser;
	}

	@RequestMapping(value="json/addUser" , method=RequestMethod.POST) //2019.05.03
	public void addUser(@RequestBody User user) throws Exception
	{
		System.out.println("/user/json/addUser : POST");
		//Business Logic
		System.out.println("::"+user);

		userService.addUser(user);
	}

	@RequestMapping(value="json/updateUser/{userId}", method=RequestMethod.GET) //2019.05.03
	public User updateUser(@PathVariable String userId) throws Exception
	{
		System.out.println("/user/json/updateUser : GET");
		//Business Logic

		return userService.getUser(userId);
	}

	@RequestMapping(value="json/updateUser", method = RequestMethod.POST) //2019.05.07
	public Map updateUser(@RequestBody User user, HttpSession session) throws Exception //Scope는 쓸수없는ㄷㅔ session은 쓸수잇따고?
	{
		System.out.println("/user/json/updateUser :  POST");
		//Business Logic
		System.out.println("::"+user);

		//값이 널이어서 updateNull로 됨
		User sessionUser =(User) session.getAttribute("user");
		user.setUserPoint(sessionUser.getUserPoint());
		user.setTotalPayment(sessionUser.getTotalPayment());
		///////////////////////////////////////////////////////password랑 주민번호는 굳이 session에 넣지않아도될까?
		user.setSsn(sessionUser.getSsn());
		user.setPassword(sessionUser.getPassword());
		///////////////////////////////////////////////////////////////////


		userService.updateUser(user,"nothing");

		//session설정 안해줘서 . 알수없음.
		//String sessionId=((User)session.getAttribute("user")).getUserId();
		//if(sessionId.equals(user.getUserId())){
		//	session.setAttribute("user", user);
		//}
		Map map = new HashMap();
		map.put("userId", user.getUserId());

		return map; //String도 return 할수있을까?? json으로 return 하나?--> 이렇게 return 하면  id만 return json형식으로 안감
	}

	@RequestMapping(value="json/logout", method = RequestMethod.GET) //2019.05.07~08 해바
	public void logout(HttpSession session)
	{
		System.out.println("/user/json/logout :  GET");

		// session 존재 없다. 뭐 return 값 어쩌구 저쩌구
		session.invalidate();
	}

	@RequestMapping(value="json/checkDuplication", method = RequestMethod.POST) //2019.05.08
	public Map checkDuplication(HttpServletRequest request, @RequestBody User user) throws Exception // POST 방식으로 requestParam 등 하나만 받아올떄도 @RequestBody 객체로 받아와야하나.
	{
		System.out.println("/user/json/checkDuplication :  POST");

		//System.out.println(request.getParameter("userId")+"나오는가??"); // 안된다 왜냐면 request jSOn으로 오잖아.
		String a = "         ";
		System.out.println(a.isEmpty()+": 1");
		System.out.println(a.trim().length()+" : 2");
		System.out.println(a.length()+" :3");
		System.out.println("_"+a.trim()+"_");
		
		
		boolean result = userService.checkDuplication(user.getUserId());

		Map map = new HashMap();
		map.put("result", result);
		map.put("userId", user.getUserId());

		return map;
	}

	@RequestMapping(value="json/listUser", method=RequestMethod.GET) // 2019.05.08  listUser타는 get방식이, 
	public Map listUser() throws Exception
	{
		//GET 방식으로 들어올때, RequestBody하면 인자가 없어서,, 400error뜬다. ->  RequestBody는 body, get방식은 body가 없다.
		System.out.println("/user/listUser : GET / POST");

		Search search = new Search();
		//search.setCurrentPage(currentPage);

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		Map<String , Object> returnMap=userService.getUserList(search);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		Map map = new HashMap();

		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);

		return map; // getUserList()에서 수행된 totalCount도 넘어간다. -> 이제 안넘어감.
	}
	@RequestMapping(value="json/listUser", method=RequestMethod.POST) // 2019.05.08  listUser타는 get방식이, 
	public Map listUser(@RequestBody Search search) throws Exception
	{
		//GET 방식으로 들어올때, RequestBody하면 인자가 없어서,, 400error뜬다. ->  RequestBody는 body, get방식은 body가 없다.
		System.out.println("/user/listUser : GET / POST");

		//Search search = new Search();
		//search.setCurrentPage(currentPage);

		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		Map<String , Object> returnMap=userService.getUserList(search);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)returnMap.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		Map map = new HashMap();

		map.put("list", returnMap.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);

		return map; // getUserList()에서 수행된 totalCount도 넘어간다. -> 이제 안넘어감.
	}

}