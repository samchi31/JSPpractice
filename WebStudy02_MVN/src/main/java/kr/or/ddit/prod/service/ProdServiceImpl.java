package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.prod.dao.ProdDAO;
import kr.or.ddit.prod.dao.ProdDAOImpl;
import kr.or.ddit.vo.PagingVO;
import kr.or.ddit.vo.ProdVO;

public class ProdServiceImpl implements ProdService {

	private ProdDAO prodDao = new ProdDAOImpl();
	
	@Override
	public ProdVO retrieveProd(String prodId) {
		ProdVO prod = prodDao.selectProd(prodId);
		if(prod == null) {
			throw new RuntimeException(String.format("%s는 없는 상품",prodId));
		}
		return prod;
	}

	@Override
	public void retrieveProdList(PagingVO<ProdVO> pagingVO) {
		pagingVO.setTotalRecord(prodDao.selectTotalRecord(pagingVO));
		List<ProdVO> prodList = prodDao.selectProdList(pagingVO);
		pagingVO.setDataList(prodList);
	}

}
