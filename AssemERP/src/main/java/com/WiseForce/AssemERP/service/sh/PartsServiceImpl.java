/*
 * package com.WiseForce.AssemERP.service.sh;
 * 
 * import java.util.List;
 * 
 * import org.springframework.stereotype.Service;
 * 
 * import com.WiseForce.AssemERP.dao.sh.PartsDao; import
 * com.WiseForce.AssemERP.dto.sh.PartsDTO; import
 * com.WiseForce.AssemERP.repository.sh.PartsRepository;
 * 
 * import jakarta.transaction.Transactional; import
 * lombok.RequiredArgsConstructor;
 * 
 * @Service
 * 
 * @RequiredArgsConstructor
 * 
 * @Transactional public class PartsServiceImpl implements PartsService {
 * 
 * private final PartsRepository partsRepository; private final PartsDao
 * partsDao;
 * 
 * @Override public List<PartsDTO> getPartsList(PartsDTO partsDTO) {
 * List<PartsDTO> partsDtoList = partsDao.findPageList(partsDTO);
 * 
 * 
 * return partsDtoList; }
 * 
 * @Override public int getTotalcount() { int Partstotalcout = (int)
 * partsRepository.count(); return Partstotalcout; }
 * 
 * 
 * 
 * 
 * 
 * }
 */