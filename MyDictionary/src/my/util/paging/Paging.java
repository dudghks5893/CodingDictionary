package my.util.paging;


public class Paging {
	
	private int total_page = 0; // 페이징 총 개수
	private int blockStartNum = 0; //시작 블록
	private int blockLastNum = 0;  //중지 블록
	private int back = 1; // 이전 블록
	private int next = 0; // 다음 블록
	

	
public int getTotal_page() {
		return total_page;
	}

	public void setTotal_page(int total_page) {
		this.total_page = total_page;
	}

	public int getBlockStartNum() {
		return blockStartNum;
	}

	public void setBlockStartNum(int blockStartNum) {
		this.blockStartNum = blockStartNum;
	}

	public int getBlockLastNum() {
		return blockLastNum;
	}

	public void setBlockLastNum(int blockLastNum) {
		this.blockLastNum = blockLastNum;
	}

	public int getBack() {
		return back;
	}

	public void setBack(int back) {
		this.back = back;
	}

	public int getNext() {
		return next;
	}

	public void setNext(int next) {
		this.next = next;
	}

	
// 페이징 개수 구하기
		public int getPaging(int total, int LISTCOUNT) {
			int paging = 0;
			int total_record = total; // DAO에서 총 게시글 개수 구해온 값으로 계산 함 (getBoardBlockPaging() 여기에서 사용 하기 위함)
			
				if(total_record%LISTCOUNT==0) {
					paging = total_record/LISTCOUNT;
					Math.floor(paging);
				} else {
					paging = total_record/LISTCOUNT+1;
					Math.floor(paging);
				}
						
					return paging;
		}
		
// 페이징 블록 처리 (얘만 호출하면 됨)
	public void getBlockPaging(int pageNum,int total,int LISTCOUNT,int PAGECOUNT ) {
		
		int blockNum = 0;  // 블록 숫자  예)0일때 스타트 블록 1, 블록 숫자 1일때 스타트 블록 6
		int blockLast = 0; // 마지막 블록의 숫자 (나머지 페이지들만 표시하기 위함)
		total_page = getPaging(total,LISTCOUNT); // 페이징 개수  (DAO에서 총 게시글 개수 구해온 값으로 계산 함)
		
		for(int i=1; i<=total_page; i+=PAGECOUNT) {
			blockLast = i;
		}
		blockNum = (int)Math.floor((pageNum-1)/ PAGECOUNT);
        blockStartNum = (PAGECOUNT * blockNum) + 1;
        blockLastNum = blockStartNum + (PAGECOUNT-1);
        
        if(pageNum >= blockLast)// 마지막 블록
        	blockLastNum = total_page;
        
        if(PAGECOUNT<blockStartNum)//이전 블록
        	back = blockStartNum-PAGECOUNT;
        
        if(total_page > blockLastNum)
        	next = blockLastNum+1;
        else
        	next = total_page;
	}
	
}
