package com.netcracker.ncedu.tlt.dimi1.expensemanager.reports;

import com.netcracker.ncedu.tlt.dimi1.expensemanager.interfaces.PlanBudget;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.scheduling.support.CronSequenceGenerator;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class Report3 {
    private Integer id;
    private Date date;
    private BigDecimal sum;
    private String description;

    private JdbcTemplate jdbcTemplate;

    public Report3(JdbcTemplate jdbcTemplate){ this.jdbcTemplate = jdbcTemplate; }

    public void getReportRow(List<PlanBudget> plans, List<Report3> rL, Date criterialStartDate, Date criterialEndDate) {
        for(int i=0; i<plans.size(); i++){
           if(plans.get(i).getOperationDate() != null){
               if(plans.get(i).getOperationDate().after(criterialStartDate) &&
                       (plans.get(i).getOperationDate().before(criterialEndDate) ||
                       plans.get(i).getOperationDate().equals(criterialStartDate) ||
                       plans.get(i).getOperationDate().equals(criterialEndDate))){
                   Date date = plans.get(i).getOperationDate();
                   Calendar calendar = new GregorianCalendar();
                   calendar.setTime(date);
                   calendar.set(Calendar.HOUR, 0);
                   calendar.set(Calendar.MINUTE, 0);
                   date = calendar.getTime();
                   Report3 obj = new Report3(jdbcTemplate);
                   obj.setId(plans.get(i).getBudgetTypeId());
                   obj.setDate(date);
                   obj.setDescription(plans.get(i).getDescription());
                   obj.setSum(plans.get(i).getChargeValue());
                   rL.add(obj);

               }
           } else {
               if (plans.get(i).getStartDate().after(criterialStartDate) ||
                       plans.get(i).getStartDate().before(criterialEndDate) ||
                       plans.get(i).getStartDate().equals(criterialStartDate)) {
                   if (plans.get(i).getRegularMask() != null) {
                       String regM = plans.get(i).getRegularMask();
                       Date curDate = new Date();
                       CronSequenceGenerator generator = new CronSequenceGenerator(regM);
                       if (criterialStartDate.before(plans.get(i).getStartDate())) {
                           Calendar calendar = new GregorianCalendar();
                           calendar.setTime(plans.get(i).getStartDate());
                           calendar.set(Calendar.HOUR, 0);
                           calendar.set(Calendar.MINUTE, 0);
                           curDate = calendar.getTime();
                       } else if (criterialStartDate.after(plans.get(i).getStartDate())) {
                           curDate = criterialStartDate;
                       }
                       if (plans.get(i).getRepeatCount() != null) {
                           for (int z = 0; z < plans.get(i).getRepeatCount() * getCoef(regM, plans.get(i).getSpliter()); z++) {
                               Report3 obj = new Report3(jdbcTemplate);
                               obj.setId(plans.get(i).getBudgetTypeId());
                               obj.setDate(curDate);
                               obj.setDescription(plans.get(i).getDescription());
                               obj.setSum(plans.get(i).getChargeValue());
                               rL.add(obj);
                               curDate = generator.next(curDate);
                               if(curDate.after(criterialEndDate)){
                                   break;
                               }
                           }
                       } else if (plans.get(i).getRepeatCount() == null) {
                           Date end = new Date();
                           if (plans.get(i).getEndDate() != null) {
                               if (plans.get(i).getEndDate().before(criterialEndDate) ||
                                       plans.get(i).getEndDate().equals(criterialEndDate)) {
                                   Calendar calendar = new GregorianCalendar();
                                   calendar.setTime(plans.get(i).getEndDate());
                                   calendar.set(Calendar.HOUR, 0);
                                   calendar.set(Calendar.MINUTE, 0);
                                   end = calendar.getTime();
                               } else {
                                   end = criterialEndDate;
                               }
                           } else {
                               end = criterialEndDate;
                           }
                           curDate = generator.next(curDate);
                           while (curDate.before(end) || curDate.equals(end)) {
                               Report3 obj = new Report3(jdbcTemplate);
                               obj.setId(plans.get(i).getBudgetTypeId());
                               obj.setDate(curDate);
                               obj.setDescription(plans.get(i).getDescription());
                               obj.setSum(plans.get(i).getChargeValue());
                               rL.add(obj);
                               curDate = generator.next(curDate);
                           }
                       }
                   }
               }
           }
        }
    }

    public int getCoef(String regM, boolean isSplit){
        String minutes, hours;
        String[] mask = regM.split(" ");
        minutes = mask[1];
        hours = mask[2];
        return (!isSplit)?1:getCountElements(minutes) * getCountElements(hours);
    }

    public int getCountElements(String param){
        int count = 0;
        String[] sizeRes = param.split(",");
        String[][] result = new String[sizeRes.length][];
        for(int i=0; i<sizeRes.length; i++){
            if(sizeRes[i].indexOf("-") == -1){
                result[i] = new String[1];
                result[i][0] = sizeRes[i];
            } else {
                String[] sub = sizeRes[i].split("-");
                int num1 = Integer.parseInt(sub[0]);
                int num2 = Integer.parseInt(sub[1]);
                int currentNumber = num1;
                result[i] = new String[num2-num1+1];
                for(int j=0; j<num2-num1+1; j++){
                    result[i][j] = String.valueOf(currentNumber);
                    currentNumber++;
                }
            }
        }
        for(int k=0; k<result.length; k++){
            count+=result[k].length;
        }
        return count;
    }

    public void getReportRow(List<Report3> rL) {
        String getData = "SELECT budget_type_id_fk, description, summa FROM plan_budget";
        RowMapper<Report3> rowMapper = new Report3RowMapper(jdbcTemplate);
        List<Report3> getRows = jdbcTemplate.query(getData, rowMapper);
        for(Report3 i : getRows){
            rL.add(i);
        }
    }

    public Integer getId() {
        return id;
    }

    public String getDescription() {
        return description;
    }

    public BigDecimal getSum() { return sum; }

    public Date getDate() { return date;}

    public void setId(Integer id) {
        this.id = id;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setSum(BigDecimal sum) {
        this.sum = sum;
    }

    public  void setDate(Date date) { this.date = date; }
}