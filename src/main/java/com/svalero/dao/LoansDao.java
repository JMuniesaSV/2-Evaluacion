package com.svalero.dao;

import com.svalero.domain.Loan;
import org.jdbi.v3.sqlobject.config.RegisterRowMapper;
import org.jdbi.v3.sqlobject.customizer.Bind;
import org.jdbi.v3.sqlobject.statement.SqlQuery;
import org.jdbi.v3.sqlobject.statement.SqlUpdate;
import org.jdbi.v3.sqlobject.statement.UseRowMapper;

import java.sql.Date;
import java.util.List;

public interface LoansDao {

    @SqlQuery("SELECT * FROM LOANS")
    @UseRowMapper(LoansMapper.class)
    List<Loan> getAllLoans();

    @SqlQuery("SELECT l.*, m.title as movieTitle FROM loans l JOIN movies m ON l.idMovie = m.idMovie WHERE l.idUser = :idUser AND (m.title LIKE '%' || :searchTerm || '%' OR l.startDate LIKE '%' || :searchTerm || '%' OR l.expectedDate LIKE '%' || :searchTerm || '%' OR l.returnDate LIKE '%' || :searchTerm || '%')")
    @UseRowMapper(LoansMapper.class)
    List<Loan> getLoansByUserAndFilter(@Bind("idUser") int idUser, @Bind("searchTerm") String searchTerm);

    @SqlQuery("SELECT * FROM LOANS WHERE idLoan = ?")
    @UseRowMapper(LoansMapper.class)
    Loan getLoan(int idLoan);

    @SqlUpdate("INSERT INTO LOANS (idMovie, idUser, startDate, expectedDate) VALUES (?, ?, ?, ?)")
    void addLoan(int idMovie, int idUser, Date startDate, Date expectedDate);

    @SqlUpdate("UPDATE LOANS SET idLoan = ?, idMovie = ?, idUser = ?, startDate = ?, expectedDate = ?, returnDate = ? WHERE idLoan = ?")
    int updateLoan(int idLoan, int idMovie, int idUser, Date startDate, Date expectedDate, Date returnDate);

    @SqlUpdate("DELETE FROM LOANS WHERE idLoan = ?")
    int removeLoan(int idLoan);

    @SqlQuery("SELECT l.*, m.title as movieTitle FROM loans l JOIN movies m ON l.idMovie = m.idMovie WHERE l.idUser = :idUser")
    @RegisterRowMapper(LoansMapper.class)
    List<Loan> findLoansByidUser(@Bind("idUser") int idUser);

    @SqlUpdate("UPDATE loans SET returnDate = :returnDate WHERE idLoan = :idLoan AND returnDate IS NULL")
    boolean updateReturnDate(@Bind("idLoan") int idLoan, @Bind("returnDate") java.sql.Date returnDate);

    @SqlUpdate("UPDATE loans SET returnDate = :returnDate WHERE idMovie = :idMovie AND idUser = :idUser AND returnDate IS NULL")
    void returnLoan(@Bind("idMovie") int idMovie, @Bind("idUser") int idUser, @Bind("returnDate") java.sql.Date returnDate);

    @SqlUpdate("UPDATE loans SET returnDate = :returnDate WHERE idLoan = :idLoan AND returnDate IS NULL")
    void returnLoanById(@Bind("idLoan") int idLoan, @Bind("returnDate") java.sql.Date returnDate);

    @SqlQuery("SELECT COUNT(*) FROM loans WHERE idMovie = :idMovie AND idUser = :idUser AND returnDate IS NULL")
    int countActiveLoansByUser(@Bind("idMovie") int idMovie, @Bind("idUser") int idUser);
}
