-- QUERY WITH SELECT

-- 1. Selezionare tutti gli studenti nati nel 1990 (160)
SELECT * 
FROM `students`
WHERE YEAR(`date_of_birth`) = 1990;

-- 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)
SELECT * 
FROM `courses`
WHERE `cfu` > 10;

-- 3. Selezionare tutti gli studenti che hanno più di 30 anni
SELECT `date_of_birth`
FROM `students`
WHERE YEAR(`date_of_birth`) < 1994;

-- 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)
SELECT `period`, `year`
FROM `courses`
WHERE `period` = 'I semestre'
AND `year` = 1;

-- 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)
SELECT `date`,`hour`
FROM `exams`
WHERE `date` = '2020-06-20'
AND `hour` >= '14:00:00';

-- 6. Selezionare tutti i corsi di laurea magistrale (38)
SELECT `name`, `level`
FROM `degrees`
WHERE `level` = 'magistrale';

-- 7. Da quanti dipartimenti è composta l'università? (12)
SELECT COUNT(`id`) AS `total_departments`
FROM `departments`;

-- 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)
SELECT `name`, `surname`, `phone`
FROM `teachers`
WHERE `phone` IS NULL;


-------------------------------------------------------------------------------

-- QUERY WITH GROUP

-- 1. Contare quanti iscritti ci sono stati ogni anno
SELECT COUNT(`id`) AS `stud_every_year`, YEAR(`enrolment_date`) AS `enrolment_year`
FROM `students`
GROUP BY `enrolment_year`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio
SELECT COUNT(`id`) as `number_of_teachers`, `office_address` AS `common_building`
FROM `teachers`
GROUP BY `office_address`
HAVING `number_of_teachers` > 1;

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT ROUND(AVG(`vote`), 2) AS `media_voto`, `exam_id`
FROM `exam_student`
-- WHERE `vote` >= 18 (nel caso volessimo fare la media solo dei voti con cui l'esame risulta passato)
GROUP BY `exam_id`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento
SELECT COUNT(`department_id`) AS `numero_corsi`, `department_id`
FROM `degrees`
GROUP BY `department_id`;


-------------------------------------------------------------------------------
--  QUERY WITH JOIN

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia
SELECT `students`.`id` AS `id_studente`, `students`.`name` AS `Nome`, `students`.`surname` AS `Cognome`, `students`.`degree_id`, `degrees`.`name` AS `Nome Corso`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments` 
ON `departments`.`id` = `degrees`.`department_id`
WHERE `students`.`degree_id` = 53;

-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze
SELECT `departments`.`name` AS `Nome Dipartimento`, `degrees`.`name` AS `Nome Corso`
FROM `departments`
JOIN `degrees`
ON `departments`. `id` = `department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)
SELECT `teachers`. `name` AS `Nome Insegnante`, `teachers`. `surname` AS `Cognome Insegnante`, `degrees`.`name` AS `Nome Corso`
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
WHERE `course_teacher`.`teacher_id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome


-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti


-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)


-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami
