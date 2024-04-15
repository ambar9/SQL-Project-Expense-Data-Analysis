CREATE TABLE public.expenses
(
    ExpenseID SERIAL PRIMARY KEY,
    Date TIMESTAMP,
    Company TEXT,
    CategoryID INT,
    Cost NUMERIC
);

-- Create categories table with primary key
CREATE TABLE public.categories
(
    CategoryID INT PRIMARY KEY,
    Category TEXT
);

ALTER TABLE public.expenses
ADD CONSTRAINT fk_expenses_category
FOREIGN KEY (CategoryID) REFERENCES public.categories(CategoryID);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.expenses OWNER TO postgres;
ALTER TABLE public.categories OWNER TO postgres;

-- Create indexes on foreign key columns for better performance

CREATE INDEX idx_expenses_category_id ON public.expenses (CategoryID);


