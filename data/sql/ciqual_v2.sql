-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: alimentation | type: DATABASE --
-- -- DROP DATABASE IF EXISTS alimentation;
-- CREATE DATABASE alimentation;
-- -- ddl-end --
-- 

-- object: public.aliments | type: TABLE --
-- DROP TABLE IF EXISTS public.aliments CASCADE;
CREATE TABLE public.aliments (
	idx_ali integer NOT NULL,
	nom_fr varchar(255),
	nom_index_fr varchar(255),
	nom_eng varchar(255),
	nom_index_eng varchar(255),
	idx_grp_groupe_aliments integer,
	CONSTRAINT alim_pk PRIMARY KEY (idx_ali)

);
-- ddl-end --

-- object: public.groupe_aliments | type: TABLE --
-- DROP TABLE IF EXISTS public.groupe_aliments CASCADE;
CREATE TABLE public.groupe_aliments (
	idx_grp integer NOT NULL,
	nom_fr varchar,
	nom_eng varchar,
	idx_grp_groupe_aliments integer,
	CONSTRAINT alim_grp_pk PRIMARY KEY (idx_grp)

);
-- ddl-end --

-- object: public.constituants | type: TABLE --
-- DROP TABLE IF EXISTS public.constituants CASCADE;
CREATE TABLE public.constituants (
	idx_cst integer NOT NULL,
	nom_fr varchar(255),
	nom_eng varchar(255),
	CONSTRAINT pk_constituants PRIMARY KEY (idx_cst)

);
-- ddl-end --

-- object: public.sources | type: TABLE --
-- DROP TABLE IF EXISTS public.sources CASCADE;
CREATE TABLE public.sources (
	idx_src serial NOT NULL,
	code integer,
	citation text,
	CONSTRAINT pk_sources PRIMARY KEY (idx_src)

);
-- ddl-end --

-- object: groupe_aliments_fk | type: CONSTRAINT --
-- ALTER TABLE public.aliments DROP CONSTRAINT IF EXISTS groupe_aliments_fk CASCADE;
ALTER TABLE public.aliments ADD CONSTRAINT groupe_aliments_fk FOREIGN KEY (idx_grp_groupe_aliments)
REFERENCES public.groupe_aliments (idx_grp) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: groupe_aliments_fk | type: CONSTRAINT --
-- ALTER TABLE public.groupe_aliments DROP CONSTRAINT IF EXISTS groupe_aliments_fk CASCADE;
ALTER TABLE public.groupe_aliments ADD CONSTRAINT groupe_aliments_fk FOREIGN KEY (idx_grp_groupe_aliments)
REFERENCES public.groupe_aliments (idx_grp) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: ix_nom_index_fr | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_nom_index_fr CASCADE;
CREATE INDEX ix_nom_index_fr ON public.aliments
	USING btree
	(
	  nom_index_fr
	);
-- ddl-end --

-- object: ix_sources_code | type: INDEX --
-- DROP INDEX IF EXISTS public.ix_sources_code CASCADE;
CREATE INDEX ix_sources_code ON public.sources
	USING btree
	(
	  code
	);
-- ddl-end --

-- object: public.compositions | type: TABLE --
-- DROP TABLE IF EXISTS public.compositions CASCADE;
CREATE TABLE public.compositions (
	idx_cst_constituants integer NOT NULL,
	idx_ali_aliments integer NOT NULL,
	teneur varchar(255) NOT NULL,
	teneur_mini varchar(255),
	teneur_maxi varchar(255),
	code_confiance varchar(255),
	CONSTRAINT compositions_pk PRIMARY KEY (idx_cst_constituants,idx_ali_aliments)

);
-- ddl-end --
COMMENT ON COLUMN public.compositions.teneur IS E'Teneur en décimales';
-- ddl-end --
COMMENT ON COLUMN public.compositions.teneur_mini IS E'Teneur minimale';
-- ddl-end --
COMMENT ON COLUMN public.compositions.teneur_maxi IS E'teneur maximale';
-- ddl-end --
COMMENT ON COLUMN public.compositions.code_confiance IS E'Code confiance de la source';
-- ddl-end --

-- object: constituants_fk | type: CONSTRAINT --
-- ALTER TABLE public.compositions DROP CONSTRAINT IF EXISTS constituants_fk CASCADE;
ALTER TABLE public.compositions ADD CONSTRAINT constituants_fk FOREIGN KEY (idx_cst_constituants)
REFERENCES public.constituants (idx_cst) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: aliments_fk | type: CONSTRAINT --
-- ALTER TABLE public.compositions DROP CONSTRAINT IF EXISTS aliments_fk CASCADE;
ALTER TABLE public.compositions ADD CONSTRAINT aliments_fk FOREIGN KEY (idx_ali_aliments)
REFERENCES public.aliments (idx_ali) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: public.many_compositions_has_many_sources | type: TABLE --
-- DROP TABLE IF EXISTS public.many_compositions_has_many_sources CASCADE;
CREATE TABLE public.many_compositions_has_many_sources (
	idx_cst_constituants_compositions integer NOT NULL,
	idx_ali_aliments_compositions integer NOT NULL,
	idx_src_sources integer NOT NULL,
	CONSTRAINT many_compositions_has_many_sources_pk PRIMARY KEY (idx_cst_constituants_compositions,idx_ali_aliments_compositions,idx_src_sources)

);
-- ddl-end --

-- object: compositions_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_compositions_has_many_sources DROP CONSTRAINT IF EXISTS compositions_fk CASCADE;
ALTER TABLE public.many_compositions_has_many_sources ADD CONSTRAINT compositions_fk FOREIGN KEY (idx_cst_constituants_compositions,idx_ali_aliments_compositions)
REFERENCES public.compositions (idx_cst_constituants,idx_ali_aliments) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: sources_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_compositions_has_many_sources DROP CONSTRAINT IF EXISTS sources_fk CASCADE;
ALTER TABLE public.many_compositions_has_many_sources ADD CONSTRAINT sources_fk FOREIGN KEY (idx_src_sources)
REFERENCES public.sources (idx_src) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --


