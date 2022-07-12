package org.zerock.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequiredArgsConstructor
//@AllArgsConstructor  // <--이거 대신에 @RequiredArgsConstructor 이거 사용..(final) @Autowired필요없다 
@RequestMapping("/board/*")
@Log4j
public class BoardController {
	
	//주입!! 뭘주입할것인가  옆에 계층만 볼수 있다. controller <-> service
	private final BoardService service;
	
	
//	@GetMapping("/list")
//	public void list(Model model) { // 화면에 뭔가 전달해야 한다. 게시물! 게시물이 파라미터로 없다? DB통해서 가져와야한다. 그래서 Model이라는 애가 필요함.
//	//스프링MVC의 경우는 URL이 있고 리턴타입이 void면 동일한 JSP 페이지를 찾는다.	
//		log.info("list.....................");
//		
//		model.addAttribute("list", service.getList()); //이름을 뭘로 지을까.. 목록 데이터니깐 "list", 어디에서?service객체한테 list를 얻어와!
//		
//	}
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) { // 화면에 뭔가 전달해야 한다. 게시물! 게시물이 파라미터로 없다? DB통해서 가져와야한다. 그래서 Model이라는 애가 필요함.
	//스프링MVC의 경우는 URL이 있고 리턴타입이 void면 동일한 JSP 페이지를 찾는다.	
		
		log.info("----------------------------");
		log.info(cri);
		log.info("list.....................");
		
		model.addAttribute("list", service.getList(cri)); //이름을 뭘로 지을까.. 목록 데이터니깐 "list", 어디에서?service객체한테 list를 얻어와!
		model.addAttribute("pageMaker", new PageDTO(cri, service.getTotal(cri)));
		
	}
	
	@GetMapping("/register")
	public void registerGET() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes rttr) {
		//전송을 할때는 리다이렉트라는 접두어를 붙여서 보내지므로 String
		
		log.info("board : " + board);
		
		Long bno = service.register(board);
		
		log.info("BNO : " + bno);
		
		// 목록페이지로 갈떄 데이터를 전달해준다. 2가지 방법 addFlashAttribute, addAttribute
		// addFlashAttribute는 잠깐 반짝임, 아주 잠깐만 결과 데이터를 보내는 방식, 한번만 보내기 가능, 보내면 주소창에 안남는다.
		rttr.addFlashAttribute("result", bno);
		
		// addAttribute는 브라우저의 링크에 연결이된다. 링크뒤에 파라미터가 따라 붙게됨.
		// rttr.addAttribute("result", bno);
		
		return "redirect:/board/list";
	}
	
	// 게시판 리스트 클릭시 조회하기
	// 보드에 get이라고 들어오면 이 메소드를 실행 하겠다!
	// DB를 통해 새로운 데이터가 추가되서 화면에 보여줘야 하므로 Model을 쓴다.
	// 아래 메소드가 두개의 링크를 처리할수 있게 {"/get", "/modify"} 추가
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno")Long bno, @ModelAttribute("cri") Criteria cri, Model model) {
		
		model.addAttribute("board", service.get(bno));
		
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, Criteria cri, RedirectAttributes rttr) {
		int count = service.modify(board);
		
		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
			// 이름은 result고 성공했다는 메시지 전달 success!
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, Criteria cri, RedirectAttributes rttr) {
		//@RequestParam은 없어도 된다. 구분해주기위해...
		int count = service.remove(bno);
		
		if (count == 1) {
			rttr.addFlashAttribute("result", "success");
			// 이름은 result고 성공했다는 메시지 전달 success!
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}	

	
	
}
