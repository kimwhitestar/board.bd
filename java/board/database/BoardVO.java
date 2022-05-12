package board.database;

public class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String email;
	private String homepage;
	private String content;
	private String wDate;
	private int readNum;
	private String hostIp;
	private int recommendNum;
	private String mid;
	//날짜형식필드를 '문자'와 '숫자'로 나눔
	private String strWdate;//문자형날짜
	private int intWDate;//오늘날짜와 글쓴날짜의 시간차
	//이전글, 다음글
	private int preIdx;
	private int nextIdx;
	private String preTitle;
	private String nextTitle;
	
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getHomepage() {
		return homepage;
	}
	public void setHomepage(String homepage) {
		this.homepage = homepage;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getwDate() {
		return wDate;
	}
	public void setwDate(String wDate) {
		this.wDate = wDate;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public int getRecommendNum() {
		return recommendNum;
	}
	public void setRecommendNum(int recommendNum) {
		this.recommendNum = recommendNum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getStrWdate() {
		return strWdate;
	}
	public void setStrWdate(String strWdate) {
		this.strWdate = strWdate;
	}
	public int getIntWDate() {
		return intWDate;
	}
	public void setIntWDate(int intWDate) {
		this.intWDate = intWDate;
	}
	public int getPreIdx() {
		return preIdx;
	}
	public void setPreIdx(int preIdx) {
		this.preIdx = preIdx;
	}
	public int getNextIdx() {
		return nextIdx;
	}
	public void setNextIdx(int nextIdx) {
		this.nextIdx = nextIdx;
	}
	public String getPreTitle() {
		return preTitle;
	}
	public void setPreTitle(String preTitle) {
		this.preTitle = preTitle;
	}
	public String getNextTitle() {
		return nextTitle;
	}
	public void setNextTitle(String nextTitle) {
		this.nextTitle = nextTitle;
	}
	@Override
	public String toString() {
		return "BoardVO [idx=" + idx + ", nickName=" + nickName + ", title=" + title + ", email=" + email + ", homepage="
				+ homepage + ", content=" + content + ", wDate=" + wDate + ", readNum=" + readNum + ", hostIp=" + hostIp
				+ ", recommendNum=" + recommendNum + ", mid=" + mid + ", strWdate=" + strWdate + ", intWDate=" + intWDate
				+ ", preIdx=" + preIdx + ", nextIdx=" + nextIdx + ", preTitle=" + preTitle + ", nextTitle=" + nextTitle + "]";
	}
}