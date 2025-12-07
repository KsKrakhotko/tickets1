package org.example.tickets.request;

public class StationRequest {
    private String name;
    private String city;
    private String region;

    public StationRequest() {
    }

    public StationRequest(String name, String city, String region) {
        this.name = name;
        this.city = city;
        this.region = region;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getRegion() {
        return region;
    }

    public void setRegion(String region) {
        this.region = region;
    }
}
