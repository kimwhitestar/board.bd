package board.database;

public class BoardVO {
	private int idx;
	private String nickName;
	private String title;
	private String email;
	private String homepage;
	private String content;
	private String wDate;
	private String mid;
	private String hostIp;
	private int readNum;//조회수
	private int recommendNum;//좋아요
	private int noRecommendNum;//싫어요
	private int replyNum;//댓글수
	//날짜형식필드를 '문자'와 '숫자'로 나눔
	private String strWdate;//문자형날짜
	private int intWDate;//오늘날짜와 글쓴날짜의 시간차
	private int preIdx;//이전글의 목록 번호
	private int nextIdx;//다음글의 목록 번호
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
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getHostIp() {
		return hostIp;
	}
	public void setHostIp(String hostIp) {
		this.hostIp = hostIp;
	}
	public int getReadNum() {
		return readNum;
	}
	public void setReadNum(int readNum) {
		this.readNum = readNum;
	}
	public int getRecommendNum() {
		return recommendNum;
	}
	public void setRecommendNum(int recommendNum) {
		this.recommendNum = recommendNum;
	}
	public int getNoRecommendNum() {
		return noRecommendNum;
	}
	public void setNoRecommendNum(int noRecommendNum) {
		this.noRecommendNum = noRecommendNum;
	}
	public int getReplyNum() {
		return replyNum;
	}
	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
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
	@Override
	public String toString() {
		return "BoardVO [idx=" + idx + ", nickName=" + nickName + ", title=" + title + ", email=" + email + ", homepage="
				+ homepage + ", content=" + content + ", wDate=" + wDate + ", mid=" + mid + ", hostIp=" + hostIp + ", readNum="
				+ readNum + ", recommendNum=" + recommendNum + ", noRecommendNum=" + noRecommendNum + ", replyNum=" + replyNum
				+ ", strWdate=" + strWdate + ", intWDate=" + intWDate + ", preIdx=" + preIdx + ", nextIdx=" + nextIdx + "]";
	}
}