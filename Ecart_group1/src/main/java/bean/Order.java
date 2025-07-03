package bean;


public class Order {
    private String orderId;
    public String userId;
    private String orderedItem;
    private String orderedDate;
    private String arrivingDate;
    private String deliveredDate;
    private String cancelledDate;
    private String address;
    private String status;

    public String getDeliveredDate() {
		return deliveredDate;
	}
	public void setDeliveredDate(String deliveredDate) {
		this.deliveredDate = deliveredDate;
	}
	public String getCancelledDate() {
		return cancelledDate;
	}
	public void setCancelledDate(String cancelledDate) {
		this.cancelledDate = cancelledDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	// Getters and Setters
    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }
    public String getOrderedItem() {
        return orderedItem;
    }
    public void setOrderedItem(String orderedItem) {
        this.orderedItem = orderedItem;
    }
    public String getOrderedDate() {
        return orderedDate;
    }
    public void setOrderedDate(String orderedDate) {
        this.orderedDate = orderedDate;
    }
    public String getArrivingDate() {
        return arrivingDate;
    }
    public void setArrivingDate(String arrivingDate) {
        this.arrivingDate = arrivingDate;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
	
}
