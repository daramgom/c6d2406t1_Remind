package com.itwillbs.web;

import com.itwillbs.domain.WarehouseVO;
import com.itwillbs.service.WarehouseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/warehouse/*")
public class WarehouseController {

    @Autowired
    private WarehouseService warehouseService;

    // 창고 목록 조회
    @GetMapping("/wareHouseList")
    public String list(Model model) {
        List<WarehouseVO> warehouseList = warehouseService.getAllWarehouses();
        model.addAttribute("warehouseList", warehouseList);
        return "wareHouseList"; // JSP 페이지 경로
    }

    // 창고 추가 폼
    @GetMapping("/wareHouseInsert")
    public String addForm() {
        return "wareHouseInsert"; // 창고 추가 JSP 페이지 경로
    }

    // 창고 추가 처리
    @PostMapping("/wareHouseInsert")
    public String addWarehouse(@ModelAttribute WarehouseVO warehouse,
                               @RequestParam double latitude,  // 위도 파라미터 추가
                               @RequestParam double longitude) { // 경도 파라미터 추가
        // 위도와 경도를 WarehouseVO에 설정
        warehouse.setLatitude(latitude);
        warehouse.setLongitude(longitude);
        
        warehouseService.addWarehouse(warehouse);
        return "redirect:/warehouse/wareHouseList"; // 추가 후 목록 페이지로 리다이렉트
    }

    // 특정 창고 조회
    @GetMapping("/view")
    public String viewWarehouse(@RequestParam("wh_number") int whNumber, Model model) {
        WarehouseVO warehouse = warehouseService.getWarehouseById(whNumber);
        model.addAttribute("warehouse", warehouse);
        return "wareHouseView"; // 창고 상세 JSP 페이지 경로
    }

    // 창고 수정 폼
    @GetMapping("/wareHouseEdit")
    public String editForm(@RequestParam("wh_number") int whNumber, Model model) {
        WarehouseVO warehouse = warehouseService.getWarehouseById(whNumber);
        model.addAttribute("warehouse", warehouse);
        return "wareHouseEdit"; // 창고 수정 JSP 페이지 경로
    }

    // 창고 수정 처리
    @PostMapping("/warehouse/edit")
    public String editWarehouse(@ModelAttribute WarehouseVO warehouse) {
        warehouseService.updateWarehouse(warehouse);
        return "redirect:/warehouse/wareHouseList"; // 수정 후 목록 페이지로 리다이렉트
    }

    // 창고 삭제 처리 (메서드 이름 변경)
    @PostMapping("/warehouse/delete")
    public String updateWarehouseStatus(@RequestParam("wh_number") int whNumber) {
        warehouseService.updateWarehouseStatus(whNumber); // 서비스 메서드 호출 수정
        return "redirect:/warehouse/wareHouseList"; // 삭제 후 목록 페이지로 리다이렉트
    }

    // 특정 창고에 속한 제품 목록 조회
    @GetMapping("/products")
    public String viewProducts(@RequestParam("wh_number") int whNumber, Model model) {
        List<WarehouseVO> products = warehouseService.getProductsByWarehouseId(whNumber);
        model.addAttribute("products", products);
        return "warehouseProductList"; // 제품 목록 JSP 페이지 경로
    }
    // 창고 목록을 JSON 형식으로 반환
    @GetMapping("/getAllWarehouses")
    @ResponseBody
    public List<WarehouseVO> getAllWarehouses() {
        return warehouseService.getAllWarehouses();
    }

    // 창고 지도 페이지 반환
    @GetMapping("/wareHouseMap") // 매핑 추가
    public String showMap() {
        return "wareHouseMap"; // JSP 페이지 경로
    }
}
