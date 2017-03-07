package cn.com.start.utils;

import org.springframework.beans.factory.annotation.Value;

public class SysConfig {
	
	/**
	 * 配置文件相对路径及名称
	 */
	@Value("${huiwei.uploadPath}")
	private String uploadPath;
	@Value("${huiwei.uploadPath.case}")
	private String casePath;
	@Value("${huiwei.uploadPath.sufferer}")
	private String suffererPath;
	@Value("${huiwei.uploadPath.doctor}")
	private String doctorPath;
	@Value("${huiwei.uploadPath.hospital}")
	private String hospitalPath;
	@Value("${huiwei.uploadPath.banner}")
	private String bannerPath;
	@Value("${huiwei.uploadPath.article}")
	private String articlePath;
	
	public String getUploadPath() {
		return uploadPath;
	}
	public String getCasePath() {
		return casePath;
	}
	public String getSuffererPath() {
		return suffererPath;
	}
	public String getDoctorPath() {
		return doctorPath;
	}
	public String getHospitalPath() {
		return hospitalPath;
	}
	public String getBannerPath() {
		return bannerPath;
	}
	public String getArticlePath() {
		return articlePath;
	}

}
