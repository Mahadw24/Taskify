-- CreateEnum
CREATE TYPE "Trello_ACTION" AS ENUM ('CREATE', 'UPDATE', 'DELETE');

-- CreateEnum
CREATE TYPE "Trello_ENTITY_TYPE" AS ENUM ('BOARD', 'LIST', 'CARD');

-- CreateTable
CREATE TABLE "Trello_Board" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "imageId" TEXT NOT NULL,
    "imageThumbUrl" TEXT NOT NULL,
    "imageFullUrl" TEXT NOT NULL,
    "imageUserName" TEXT NOT NULL,
    "imageLinkHTML" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trello_Board_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trello_List" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "boardId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trello_List_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trello_Card" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "description" TEXT,
    "listId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trello_Card_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trello_AuditLog" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "action" "Trello_ACTION" NOT NULL,
    "entityId" TEXT NOT NULL,
    "entityType" "Trello_ENTITY_TYPE" NOT NULL,
    "entityTitle" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "userImage" TEXT NOT NULL,
    "userName" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trello_AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trello_OrgLimit" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "count" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Trello_OrgLimit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Trello_OrgSubscription" (
    "id" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "stripe_customer_id" TEXT,
    "stripe_subscription_id" TEXT,
    "stripe_price_id" TEXT,
    "stripe_current_period_end" TIMESTAMP(3),

    CONSTRAINT "Trello_OrgSubscription_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Trello_List_boardId_idx" ON "Trello_List"("boardId");

-- CreateIndex
CREATE INDEX "Trello_Card_listId_idx" ON "Trello_Card"("listId");

-- CreateIndex
CREATE UNIQUE INDEX "Trello_OrgLimit_orgId_key" ON "Trello_OrgLimit"("orgId");

-- CreateIndex
CREATE UNIQUE INDEX "Trello_OrgSubscription_orgId_key" ON "Trello_OrgSubscription"("orgId");

-- CreateIndex
CREATE UNIQUE INDEX "Trello_OrgSubscription_stripe_customer_id_key" ON "Trello_OrgSubscription"("stripe_customer_id");

-- CreateIndex
CREATE UNIQUE INDEX "Trello_OrgSubscription_stripe_subscription_id_key" ON "Trello_OrgSubscription"("stripe_subscription_id");
