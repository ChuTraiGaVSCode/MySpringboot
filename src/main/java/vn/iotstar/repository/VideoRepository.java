package vn.iotstar.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import vn.iotstar.entity.Video;

public interface VideoRepository extends JpaRepository<Video, String> {

	List<Video> findByCategory_Categoryid(int categoryid);

	List<Video> findByActiveOrderByViewsDesc(int active);
}
