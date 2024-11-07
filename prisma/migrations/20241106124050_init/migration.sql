BEGIN TRY

BEGIN TRAN;

-- CreateTable
CREATE TABLE [dbo].[Users] (
    [userId] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [email] NVARCHAR(1000) NOT NULL,
    CONSTRAINT [Users_pkey] PRIMARY KEY CLUSTERED ([userId])
);

-- CreateTable
CREATE TABLE [dbo].[Products] (
    [productId] NVARCHAR(1000) NOT NULL,
    [name] NVARCHAR(1000) NOT NULL,
    [price] NVARCHAR(1000) NOT NULL,
    [rating] FLOAT(53),
    [stockQuantity] INT NOT NULL,
    CONSTRAINT [Products_pkey] PRIMARY KEY CLUSTERED ([productId])
);

-- CreateTable
CREATE TABLE [dbo].[Sales] (
    [saleId] NVARCHAR(1000) NOT NULL,
    [productId] NVARCHAR(1000) NOT NULL,
    [timestamp] DATETIME2 NOT NULL,
    [quantity] INT NOT NULL,
    [unitPrice] FLOAT(53) NOT NULL,
    [totalAmount] FLOAT(53) NOT NULL,
    CONSTRAINT [Sales_pkey] PRIMARY KEY CLUSTERED ([saleId])
);

-- CreateTable
CREATE TABLE [dbo].[Purchases] (
    [purchaseId] NVARCHAR(1000) NOT NULL,
    [productId] NVARCHAR(1000) NOT NULL,
    [timestamp] DATETIME2 NOT NULL,
    [quantity] INT NOT NULL,
    [unitCost] FLOAT(53) NOT NULL,
    [totalCost] FLOAT(53) NOT NULL,
    CONSTRAINT [Purchases_pkey] PRIMARY KEY CLUSTERED ([purchaseId])
);

-- CreateTable
CREATE TABLE [dbo].[Expenses] (
    [expenseId] NVARCHAR(1000) NOT NULL,
    [category] NVARCHAR(1000) NOT NULL,
    [amount] FLOAT(53) NOT NULL,
    [timestamp] DATETIME2 NOT NULL,
    CONSTRAINT [Expenses_pkey] PRIMARY KEY CLUSTERED ([expenseId])
);

-- CreateTable
CREATE TABLE [dbo].[SalesSummary] (
    [salesSummaryId] NVARCHAR(1000) NOT NULL,
    [totalValue] FLOAT(53) NOT NULL,
    [changePercentage] FLOAT(53) NOT NULL,
    [date] DATETIME2 NOT NULL,
    CONSTRAINT [SalesSummary_pkey] PRIMARY KEY CLUSTERED ([salesSummaryId])
);

-- CreateTable
CREATE TABLE [dbo].[PurchaseSummary] (
    [purchaseSummaryId] NVARCHAR(1000) NOT NULL,
    [totalPurchased] FLOAT(53) NOT NULL,
    [changePercentage] FLOAT(53),
    [date] DATETIME2 NOT NULL,
    CONSTRAINT [PurchaseSummary_pkey] PRIMARY KEY CLUSTERED ([purchaseSummaryId])
);

-- CreateTable
CREATE TABLE [dbo].[ExpenseSummary] (
    [expenseSummaryId] NVARCHAR(1000) NOT NULL,
    [totalExpenses] FLOAT(53) NOT NULL,
    [date] DATETIME2 NOT NULL,
    CONSTRAINT [ExpenseSummary_pkey] PRIMARY KEY CLUSTERED ([expenseSummaryId])
);

-- CreateTable
CREATE TABLE [dbo].[ExpenseByCategory] (
    [expenseByCategoryId] NVARCHAR(1000) NOT NULL,
    [expenseSummaryId] NVARCHAR(1000) NOT NULL,
    [category] NVARCHAR(1000) NOT NULL,
    [amount] BIGINT NOT NULL,
    [date] DATETIME2 NOT NULL,
    CONSTRAINT [ExpenseByCategory_pkey] PRIMARY KEY CLUSTERED ([expenseByCategoryId])
);

-- AddForeignKey
ALTER TABLE [dbo].[Sales] ADD CONSTRAINT [Sales_productId_fkey] FOREIGN KEY ([productId]) REFERENCES [dbo].[Products]([productId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[Purchases] ADD CONSTRAINT [Purchases_productId_fkey] FOREIGN KEY ([productId]) REFERENCES [dbo].[Products]([productId]) ON DELETE NO ACTION ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE [dbo].[ExpenseByCategory] ADD CONSTRAINT [ExpenseByCategory_expenseSummaryId_fkey] FOREIGN KEY ([expenseSummaryId]) REFERENCES [dbo].[ExpenseSummary]([expenseSummaryId]) ON DELETE NO ACTION ON UPDATE CASCADE;

COMMIT TRAN;

END TRY
BEGIN CATCH

IF @@TRANCOUNT > 0
BEGIN
    ROLLBACK TRAN;
END;
THROW

END CATCH
