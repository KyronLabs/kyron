-- The language each device's app is in, so its pushes can be said in it.
ALTER TABLE "DeviceToken" ADD COLUMN "locale" TEXT;
