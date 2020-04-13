SELECT b.stvterm_desc,
       j.scbcrse_title,
       a.ssbsect_ssts_code,
       a.ssbsect_subj_code,
       a.ssbsect_crse_numb,
       a.ssbsect_seq_numb,
       a.ssbsect_ptrm_code,
       a.ssbsect_max_enrl,
       j.scbcrse_coll_code,
       f.sirasgn_primary_ind,
       k.spriden_first_Name,
       k.spriden_last_Name,
       e.gtvinsm_desc,
      CASE WHEN g.pebempl_ecls_code IN ('F2','F9') THEN 'FT'
           ELSE 'PT'
           END AS instructor_type
      FROM ssbsect a
 LEFT JOIN stvterm b
        ON a.ssbsect_term_code = b.stvterm_code
 LEFT JOIN gtvinsm e
        ON a.ssbsect_insm_code = e.gtvinsm_code
 LEFT JOIN sirasgn f
        ON a.ssbsect_term_code = f.sirasgn_term_code
       AND a.ssbsect_crn = f.sirasgn_crn
       AND f.sirasgn_primary_ind = 'Y'
 LEFT JOIN pebempl g
        ON f.sirasgn_pidm = g.pebempl_pidm
 LEFT JOIN scbcrse j
        ON a.ssbsect_subj_code = j.scbcrse_subj_code
       AND a.ssbsect_crse_numb = j.scbcrse_crse_numb
 LEFT JOIN spriden k
        ON f.sirasgn_pidm = k.spriden_pidm
     WHERE a.ssbsect_ssts_code = 'A'
       AND a.ssbsect_term_code = '202030'
       AND k.spriden_change_ind IS NULL
       AND j.scbcrse_eff_term = (SELECT MAX(aa.scbcrse_eff_term)
                                    FROM scbcrse aa
                                   WHERE aa.scbcrse_eff_term <= a.ssbsect_term_code
                                     AND j.scbcrse_subj_code = aa.scbcrse_subj_code
                                     AND j.scbcrse_crse_numb = aa.scbcrse_crse_numb)
  GROUP BY b.stvterm_desc,
           j.scbcrse_eff_term,
           j.scbcrse_title,
           a.ssbsect_ssts_code,
           a.ssbsect_subj_code,
           a.ssbsect_crse_numb,
           a.ssbsect_seq_numb,
           a.ssbsect_ptrm_code,
           a.ssbsect_max_enrl,
           j.scbcrse_coll_code,
           f.sirasgn_primary_ind,
           k.spriden_First_Name,
           k.spriden_Last_Name,
           e.gtvinsm_desc,
           CASE WHEN g.pebempl_ecls_code IN ('F2','F9') THEN 'FT'
                ELSE 'PT'
                END;
