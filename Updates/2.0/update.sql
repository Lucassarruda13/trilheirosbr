-- Add columns deposits
ALTER TABLE `deposits`
  ADD COLUMN `success_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `admin_feedback`,
  ADD COLUMN `failed_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `success_url`,
  ADD COLUMN `last_cron` int DEFAULT '0' AFTER `failed_url`;

-- Modify column attributes
ALTER TABLE `deposits`
  MODIFY COLUMN `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



-- Add columns
ALTER TABLE `frontends`
  ADD COLUMN `seo_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci AFTER `data_values`,
  ADD COLUMN `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `tempname`;

-- Modify column attributes
ALTER TABLE `frontends`
  MODIFY COLUMN `data_keys` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `data_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;




-- Add column
ALTER TABLE `gateways`
  ADD COLUMN `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `alias`;

-- Modify column attributes
ALTER TABLE `gateways`
  MODIFY COLUMN `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `alias` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  MODIFY COLUMN `gateway_parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  MODIFY COLUMN `supported_currencies` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  MODIFY COLUMN `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  MODIFY COLUMN `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



-- Remove column
ALTER TABLE `gateway_currencies`
  DROP COLUMN `image`;

-- Modify column attributes
ALTER TABLE `gateway_currencies`
  MODIFY COLUMN `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `currency` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `symbol` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `gateway_alias` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  MODIFY COLUMN `gateway_parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



ALTER TABLE `general_settings`
  ADD COLUMN `email_from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email_from`,
  ADD COLUMN `sms_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email_template`,
  ADD COLUMN `push_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `sms_from`,
  ADD COLUMN `push_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `push_title`,
  ADD COLUMN `firebase_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci AFTER `sms_config`,
  ADD COLUMN `pn` tinyint(1) NOT NULL DEFAULT '1' AFTER `sn`,
  ADD COLUMN `socialite_credentials` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci AFTER `active_template`,
  ADD COLUMN `available_version` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `last_cron`,
  ADD COLUMN `paginate_number` int NOT NULL DEFAULT '0' AFTER `system_customized`,
  ADD COLUMN `currency_format` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>Both, 2=>Text Only, 3=>Symbol Only' AFTER `paginate_number`;



-- Drop column
ALTER TABLE `languages`
  DROP COLUMN `flag`;

-- Add column
ALTER TABLE `languages`
  ADD COLUMN `image` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `is_default`;


-- Add column
ALTER TABLE `notification_logs`
  ADD COLUMN `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `notification_type`;

-- Rename column
ALTER TABLE `notification_templates`
  CHANGE COLUMN `subj` `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL;

-- Add columns
ALTER TABLE `notification_templates`
  ADD COLUMN `push_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `subject`,
  ADD COLUMN `push_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci AFTER `sms_body`,
  ADD COLUMN `email_sent_from_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email_status`,
  ADD COLUMN `email_sent_from_address` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email_sent_from_name`,
  ADD COLUMN `sms_sent_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `sms_status`,
  ADD COLUMN `push_status` tinyint(1) NOT NULL DEFAULT '0' AFTER `sms_sent_from`;


ALTER TABLE `organizers`
  ADD COLUMN `dial_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email`,
  ADD COLUMN `country_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `dial_code`,
  ADD COLUMN `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `country_name`,
  ADD COLUMN `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `city`,
  ADD COLUMN `zip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `state`,
  ADD COLUMN `kyc_rejection_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `zip`,
  ADD COLUMN `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `kyc_rejection_reason`;


ALTER TABLE `organizer_password_resets`
DROP COLUMN `status`;

ALTER TABLE `pages`
ADD COLUMN `seo_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci AFTER `secs`;


CREATE TABLE `sessions` (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `organizer_id` int NOT NULL DEFAULT '0',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

ALTER TABLE `support_attachments`
MODIFY COLUMN `support_message_id` int UNSIGNED NOT NULL DEFAULT '0';

ALTER TABLE `users`
MODIFY COLUMN `username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  ADD COLUMN `dial_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `email`,
  ADD COLUMN `country_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `dial_code`,
  ADD COLUMN `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `country_name`,
  ADD COLUMN `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `city`,
  ADD COLUMN `zip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `state`,
  ADD COLUMN `kyc_rejection_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `zip`,
  ADD COLUMN `provider` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `kyc_rejection_reason`;

  ALTER TABLE `user_logins`
CHANGE COLUMN `user_ip` `ip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL;


ALTER TABLE `withdraw_methods`
ADD COLUMN `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL AFTER `name`;

CREATE TABLE `cache` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `cache_locks` (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `device_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `organizer_id` int NOT NULL DEFAULT '0',
  `is_app` tinyint(1) NOT NULL DEFAULT '0',
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;



ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);


ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);


ALTER TABLE `device_tokens`
MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;



-- insert to database 


INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES (NULL, '0', '510', 'Binance', 'Binance', '1', '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"tsu3tjiq0oqfbtmlbevoeraxhfbp3brejnm9txhjxcp4to29ujvakvfl1ibsn3ja\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"jzngq4t04ltw8d4iqpi7admfl8tvnpehxnmi34id1zvfaenbwwvsvw7llw3zdko8\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"231129033\"}}', '{\"BTC\":\"Bitcoin\",\"USD\":\"USD\",\"BNB\":\"BNB\"}', '1', '', NULL, NULL, '2023-02-14 11:08:04');


INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES (NULL, '0', '124', 'SslCommerz', 'SslCommerz', '1', '{\"store_id\": {\"title\": \"Store ID\",\"global\": true,\"value\": \"---------\"},\"store_password\": {\"title\": \"Store Password\",\"global\": true,\"value\": \"----------\"}}', '{\"BDT\":\"BDT\",\"USD\":\"USD\",\"EUR\":\"EUR\",\"SGD\":\"SGD\",\"INR\":\"INR\",\"MYR\":\"MYR\"}', '0', NULL, NULL, NULL, '2023-05-06 13:43:01');

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES (NULL, '0', '125', 'Aamarpay', 'Aamarpay', '1', '{\"store_id\": {\"title\": \"Store ID\",\"global\": true,\"value\": \"---------\"},\"signature_key\": {\"title\": \"Signature Key\",\"global\": true,\"value\": \"----------\"}}', '{\"BDT\":\"BDT\"}', '0', NULL, NULL, NULL, '2023-05-06 13:43:01');

UPDATE `general_settings` SET `socialite_credentials` = '{\"google\":{\"client_id\":\"------------\",\"client_secret\":\"-------------\",\"status\":1},\"facebook\":{\"client_id\":\"------\",\"client_secret\":\"------\",\"status\":1},\"linkedin\":{\"client_id\":\"-----\",\"client_secret\":\"-----\",\"status\":1}}' WHERE `general_settings`.`id` = 1;

UPDATE `extensions` SET `script` = '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{measurement_id}}\"></script>\n                <script>\n                  window.dataLayer = window.dataLayer || [];\n                  function gtag(){dataLayer.push(arguments);}\n                  gtag(\"js\", new Date());\n                \n                  gtag(\"config\", \"{{measurement_id}}\");\n                </script>' WHERE `extensions`.`act` = 'google-analytics';

UPDATE `extensions` SET `shortcode` = '{\"measurement_id\":{\"title\":\"Measurement ID\",\"value\":\"------\"}}' WHERE `extensions`.`act` = 'google-analytics';

UPDATE `gateways` SET `extra` = '{\"cron\":{\"title\": \"Cron Job URL\",\"value\":\"ipn.Binance\"}}' WHERE `gateways`.`alias` = 'Binance';

UPDATE `notification_templates` SET `name` = 'KYC Rejected' WHERE `notification_templates`.`act` = 'KYC_REJECT';

UPDATE `notification_templates` SET `shortcodes` = '{\"reason\":\"Rejection Reason\"}' WHERE `notification_templates`.`act` = 'KYC_REJECT';

UPDATE `gateways` SET `supported_currencies` = '{\"USD\":\"USD\",\"EUR\":\"EUR\"}' WHERE `gateways`.`alias` = 'NowPaymentsCheckout';

UPDATE `gateways` SET `crypto` = '0' WHERE `gateways`.`alias` = 'TwoCheckout';


-- v5.0.1 update
UPDATE `extensions` SET `support` = 'fb_com.png' WHERE `extensions`.`act` = 'fb-comment';

ALTER TABLE `users` ADD `provider_id` VARCHAR(255) NULL DEFAULT NULL AFTER `provider`;
ALTER TABLE `organizers` ADD `provider_id` VARCHAR(255) NULL DEFAULT NULL AFTER `provider`;

DROP TABLE `cache`, `cache_locks`, `sessions`;
ALTER TABLE `notification_logs` ADD `user_read` TINYINT NOT NULL DEFAULT '0' AFTER `image`;

UPDATE `general_settings` SET `available_version` = '0' WHERE `general_settings`.`id` = 1;

UPDATE frontends
SET slug = LOWER(REPLACE(REPLACE(REPLACE(
    JSON_UNQUOTE(JSON_EXTRACT(data_values, '$.title')), ' ', '-'), ',', ''), '.', ''))
WHERE data_keys = 'blog.element';
UPDATE frontends
SET slug = LOWER(REPLACE(REPLACE(REPLACE(
    JSON_UNQUOTE(JSON_EXTRACT(data_values, '$.title')), ' ', '-'), ',', ''), '.', ''))
WHERE data_keys = 'policy_pages.element';

-- users table 
ALTER TABLE `users` CHANGE `address` `old_address` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'contains full address';

ALTER TABLE `users`
ADD COLUMN `address` TEXT NULL AFTER `zip`;

UPDATE `users`
SET 
    `country_name` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.country')),
    `zip` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.zip')),
    `city` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.city')),
    `state` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.state')),
    `address` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.address'));

ALTER TABLE `users` DROP `old_address`;

-- organizers table  
ALTER TABLE `organizers` CHANGE `address` `old_address` TEXT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'contains full address';

ALTER TABLE `organizers`
ADD COLUMN `address` TEXT NULL AFTER `zip`;

UPDATE `organizers`
SET 
    `country_name` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.country')),
    `zip` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.zip')),
    `city` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.city')),
    `state` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.state')),
    `address` = JSON_UNQUOTE(JSON_EXTRACT(`old_address`, '$.address'));

ALTER TABLE `organizers` DROP `old_address`;


ALTER TABLE `general_settings` ADD `country_list` LONGTEXT NULL DEFAULT NULL AFTER `socialite_credentials`;

UPDATE `general_settings` SET `country_list` = '{\n  \"AF\": {\n    \"country\": \"Afghanistan\",\n    \"dial_code\": \"93\"\n  },\n  \"AX\": {\n    \"country\": \"Aland Islands\",\n    \"dial_code\": \"358\"\n  },\n  \"AL\": {\n    \"country\": \"Albania\",\n    \"dial_code\": \"355\"\n  },\n  \"DZ\": {\n    \"country\": \"Algeria\",\n    \"dial_code\": \"213\"\n  },\n  \"AS\": {\n    \"country\": \"AmericanSamoa\",\n    \"dial_code\": \"1684\"\n  },\n  \"AD\": {\n    \"country\": \"Andorra\",\n    \"dial_code\": \"376\"\n  },\n  \"AO\": {\n    \"country\": \"Angola\",\n    \"dial_code\": \"244\"\n  },\n  \"AI\": {\n    \"country\": \"Anguilla\",\n    \"dial_code\": \"1264\"\n  },\n  \"AQ\": {\n    \"country\": \"Antarctica\",\n    \"dial_code\": \"672\"\n  },\n  \"AG\": {\n    \"country\": \"Antigua and Barbuda\",\n    \"dial_code\": \"1268\"\n  },\n  \"AR\": {\n    \"country\": \"Argentina\",\n    \"dial_code\": \"54\"\n  },\n  \"AM\": {\n    \"country\": \"Armenia\",\n    \"dial_code\": \"374\"\n  },\n  \"AW\": {\n    \"country\": \"Aruba\",\n    \"dial_code\": \"297\"\n  },\n  \"AU\": {\n    \"country\": \"Australia\",\n    \"dial_code\": \"61\"\n  },\n  \"AT\": {\n    \"country\": \"Austria\",\n    \"dial_code\": \"43\"\n  },\n  \"AZ\": {\n    \"country\": \"Azerbaijan\",\n    \"dial_code\": \"994\"\n  },\n  \"BS\": {\n    \"country\": \"Bahamas\",\n    \"dial_code\": \"1242\"\n  },\n  \"BH\": {\n    \"country\": \"Bahrain\",\n    \"dial_code\": \"973\"\n  },\n  \"BD\": {\n    \"country\": \"Bangladesh\",\n    \"dial_code\": \"880\"\n  },\n  \"BB\": {\n    \"country\": \"Barbados\",\n    \"dial_code\": \"1246\"\n  },\n  \"BY\": {\n    \"country\": \"Belarus\",\n    \"dial_code\": \"375\"\n  },\n  \"BE\": {\n    \"country\": \"Belgium\",\n    \"dial_code\": \"32\"\n  },\n  \"BZ\": {\n    \"country\": \"Belize\",\n    \"dial_code\": \"501\"\n  },\n  \"BJ\": {\n    \"country\": \"Benin\",\n    \"dial_code\": \"229\"\n  },\n  \"BM\": {\n    \"country\": \"Bermuda\",\n    \"dial_code\": \"1441\"\n  },\n  \"BT\": {\n    \"country\": \"Bhutan\",\n    \"dial_code\": \"975\"\n  },\n  \"BO\": {\n    \"country\": \"Plurinational State of Bolivia\",\n    \"dial_code\": \"591\"\n  },\n  \"BA\": {\n    \"country\": \"Bosnia and Herzegovina\",\n    \"dial_code\": \"387\"\n  },\n  \"BW\": {\n    \"country\": \"Botswana\",\n    \"dial_code\": \"267\"\n  },\n  \"BR\": {\n    \"country\": \"Brazil\",\n    \"dial_code\": \"55\"\n  },\n  \"IO\": {\n    \"country\": \"British Indian Ocean Territory\",\n    \"dial_code\": \"246\"\n  },\n  \"BN\": {\n    \"country\": \"Brunei Darussalam\",\n    \"dial_code\": \"673\"\n  },\n  \"BG\": {\n    \"country\": \"Bulgaria\",\n    \"dial_code\": \"359\"\n  },\n  \"BF\": {\n    \"country\": \"Burkina Faso\",\n    \"dial_code\": \"226\"\n  },\n  \"BI\": {\n    \"country\": \"Burundi\",\n    \"dial_code\": \"257\"\n  },\n  \"KH\": {\n    \"country\": \"Cambodia\",\n    \"dial_code\": \"855\"\n  },\n  \"CM\": {\n    \"country\": \"Cameroon\",\n    \"dial_code\": \"237\"\n  },\n  \"CA\": {\n    \"country\": \"Canada\",\n    \"dial_code\": \"1\"\n  },\n  \"CV\": {\n    \"country\": \"Cape Verde\",\n    \"dial_code\": \"238\"\n  },\n  \"KY\": {\n    \"country\": \"Cayman Islands\",\n    \"dial_code\": \" 345\"\n  },\n  \"CF\": {\n    \"country\": \"Central African Republic\",\n    \"dial_code\": \"236\"\n  },\n  \"TD\": {\n    \"country\": \"Chad\",\n    \"dial_code\": \"235\"\n  },\n  \"CL\": {\n    \"country\": \"Chile\",\n    \"dial_code\": \"56\"\n  },\n  \"CN\": {\n    \"country\": \"China\",\n    \"dial_code\": \"86\"\n  },\n  \"CX\": {\n    \"country\": \"Christmas Island\",\n    \"dial_code\": \"61\"\n  },\n  \"CC\": {\n    \"country\": \"Cocos (Keeling) Islands\",\n    \"dial_code\": \"61\"\n  },\n  \"CO\": {\n    \"country\": \"Colombia\",\n    \"dial_code\": \"57\"\n  },\n  \"KM\": {\n    \"country\": \"Comoros\",\n    \"dial_code\": \"269\"\n  },\n  \"CG\": {\n    \"country\": \"Congo\",\n    \"dial_code\": \"242\"\n  },\n  \"CD\": {\n    \"country\": \"The Democratic Republic of the Congo\",\n    \"dial_code\": \"243\"\n  },\n  \"CK\": {\n    \"country\": \"Cook Islands\",\n    \"dial_code\": \"682\"\n  },\n  \"CR\": {\n    \"country\": \"Costa Rica\",\n    \"dial_code\": \"506\"\n  },\n  \"CI\": {\n    \"country\": \"Cote d\'Ivoire\",\n    \"dial_code\": \"225\"\n  },\n  \"HR\": {\n    \"country\": \"Croatia\",\n    \"dial_code\": \"385\"\n  },\n  \"CU\": {\n    \"country\": \"Cuba\",\n    \"dial_code\": \"53\"\n  },\n  \"CY\": {\n    \"country\": \"Cyprus\",\n    \"dial_code\": \"357\"\n  },\n  \"CZ\": {\n    \"country\": \"Czech Republic\",\n    \"dial_code\": \"420\"\n  },\n  \"DK\": {\n    \"country\": \"Denmark\",\n    \"dial_code\": \"45\"\n  },\n  \"DJ\": {\n    \"country\": \"Djibouti\",\n    \"dial_code\": \"253\"\n  },\n  \"DM\": {\n    \"country\": \"Dominica\",\n    \"dial_code\": \"1767\"\n  },\n  \"DO\": {\n    \"country\": \"Dominican Republic\",\n    \"dial_code\": \"1849\"\n  },\n  \"EC\": {\n    \"country\": \"Ecuador\",\n    \"dial_code\": \"593\"\n  },\n  \"EG\": {\n    \"country\": \"Egypt\",\n    \"dial_code\": \"20\"\n  },\n  \"SV\": {\n    \"country\": \"El Salvador\",\n    \"dial_code\": \"503\"\n  },\n  \"GQ\": {\n    \"country\": \"Equatorial Guinea\",\n    \"dial_code\": \"240\"\n  },\n  \"ER\": {\n    \"country\": \"Eritrea\",\n    \"dial_code\": \"291\"\n  },\n  \"EE\": {\n    \"country\": \"Estonia\",\n    \"dial_code\": \"372\"\n  },\n  \"ET\": {\n    \"country\": \"Ethiopia\",\n    \"dial_code\": \"251\"\n  },\n  \"FK\": {\n    \"country\": \"Falkland Islands (Malvinas)\",\n    \"dial_code\": \"500\"\n  },\n  \"FO\": {\n    \"country\": \"Faroe Islands\",\n    \"dial_code\": \"298\"\n  },\n  \"FJ\": {\n    \"country\": \"Fiji\",\n    \"dial_code\": \"679\"\n  },\n  \"FI\": {\n    \"country\": \"Finland\",\n    \"dial_code\": \"358\"\n  },\n  \"FR\": {\n    \"country\": \"France\",\n    \"dial_code\": \"33\"\n  },\n  \"GF\": {\n    \"country\": \"French Guiana\",\n    \"dial_code\": \"594\"\n  },\n  \"PF\": {\n    \"country\": \"French Polynesia\",\n    \"dial_code\": \"689\"\n  },\n  \"GA\": {\n    \"country\": \"Gabon\",\n    \"dial_code\": \"241\"\n  },\n  \"GM\": {\n    \"country\": \"Gambia\",\n    \"dial_code\": \"220\"\n  },\n  \"GE\": {\n    \"country\": \"Georgia\",\n    \"dial_code\": \"995\"\n  },\n  \"DE\": {\n    \"country\": \"Germany\",\n    \"dial_code\": \"49\"\n  },\n  \"GH\": {\n    \"country\": \"Ghana\",\n    \"dial_code\": \"233\"\n  },\n  \"GI\": {\n    \"country\": \"Gibraltar\",\n    \"dial_code\": \"350\"\n  },\n  \"GR\": {\n    \"country\": \"Greece\",\n    \"dial_code\": \"30\"\n  },\n  \"GL\": {\n    \"country\": \"Greenland\",\n    \"dial_code\": \"299\"\n  },\n  \"GD\": {\n    \"country\": \"Grenada\",\n    \"dial_code\": \"1473\"\n  },\n  \"GP\": {\n    \"country\": \"Guadeloupe\",\n    \"dial_code\": \"590\"\n  },\n  \"GU\": {\n    \"country\": \"Guam\",\n    \"dial_code\": \"1671\"\n  },\n  \"GT\": {\n    \"country\": \"Guatemala\",\n    \"dial_code\": \"502\"\n  },\n  \"GG\": {\n    \"country\": \"Guernsey\",\n    \"dial_code\": \"44\"\n  },\n  \"GN\": {\n    \"country\": \"Guinea\",\n    \"dial_code\": \"224\"\n  },\n  \"GW\": {\n    \"country\": \"Guinea-Bissau\",\n    \"dial_code\": \"245\"\n  },\n  \"GY\": {\n    \"country\": \"Guyana\",\n    \"dial_code\": \"595\"\n  },\n  \"HT\": {\n    \"country\": \"Haiti\",\n    \"dial_code\": \"509\"\n  },\n  \"VA\": {\n    \"country\": \"Holy See (Vatican City State)\",\n    \"dial_code\": \"379\"\n  },\n  \"HN\": {\n    \"country\": \"Honduras\",\n    \"dial_code\": \"504\"\n  },\n  \"HK\": {\n    \"country\": \"Hong Kong\",\n    \"dial_code\": \"852\"\n  },\n  \"HU\": {\n    \"country\": \"Hungary\",\n    \"dial_code\": \"36\"\n  },\n  \"IS\": {\n    \"country\": \"Iceland\",\n    \"dial_code\": \"354\"\n  },\n  \"IN\": {\n    \"country\": \"India\",\n    \"dial_code\": \"91\"\n  },\n  \"ID\": {\n    \"country\": \"Indonesia\",\n    \"dial_code\": \"62\"\n  },\n  \"IR\": {\n    \"country\": \"Iran - Islamic Republic of Persian Gulf\",\n    \"dial_code\": \"98\"\n  },\n  \"IQ\": {\n    \"country\": \"Iraq\",\n    \"dial_code\": \"964\"\n  },\n  \"IE\": {\n    \"country\": \"Ireland\",\n    \"dial_code\": \"353\"\n  },\n  \"IM\": {\n    \"country\": \"Isle of Man\",\n    \"dial_code\": \"44\"\n  },\n  \"IL\": {\n    \"country\": \"Israel\",\n    \"dial_code\": \"972\"\n  },\n  \"IT\": {\n    \"country\": \"Italy\",\n    \"dial_code\": \"39\"\n  },\n  \"JM\": {\n    \"country\": \"Jamaica\",\n    \"dial_code\": \"1876\"\n  },\n  \"JP\": {\n    \"country\": \"Japan\",\n    \"dial_code\": \"81\"\n  },\n  \"JE\": {\n    \"country\": \"Jersey\",\n    \"dial_code\": \"44\"\n  },\n  \"JO\": {\n    \"country\": \"Jordan\",\n    \"dial_code\": \"962\"\n  },\n  \"KZ\": {\n    \"country\": \"Kazakhstan\",\n    \"dial_code\": \"77\"\n  },\n  \"KE\": {\n    \"country\": \"Kenya\",\n    \"dial_code\": \"254\"\n  },\n  \"KI\": {\n    \"country\": \"Kiribati\",\n    \"dial_code\": \"686\"\n  },\n  \"KP\": {\n    \"country\": \"Democratic People\'s Republic of Korea\",\n    \"dial_code\": \"850\"\n  },\n  \"KR\": {\n    \"country\": \"Republic of South Korea\",\n    \"dial_code\": \"82\"\n  },\n  \"KW\": {\n    \"country\": \"Kuwait\",\n    \"dial_code\": \"965\"\n  },\n  \"KG\": {\n    \"country\": \"Kyrgyzstan\",\n    \"dial_code\": \"996\"\n  },\n  \"LA\": {\n    \"country\": \"Laos\",\n    \"dial_code\": \"856\"\n  },\n  \"LV\": {\n    \"country\": \"Latvia\",\n    \"dial_code\": \"371\"\n  },\n  \"LB\": {\n    \"country\": \"Lebanon\",\n    \"dial_code\": \"961\"\n  },\n  \"LS\": {\n    \"country\": \"Lesotho\",\n    \"dial_code\": \"266\"\n  },\n  \"LR\": {\n    \"country\": \"Liberia\",\n    \"dial_code\": \"231\"\n  },\n  \"LY\": {\n    \"country\": \"Libyan Arab Jamahiriya\",\n    \"dial_code\": \"218\"\n  },\n  \"LI\": {\n    \"country\": \"Liechtenstein\",\n    \"dial_code\": \"423\"\n  },\n  \"LT\": {\n    \"country\": \"Lithuania\",\n    \"dial_code\": \"370\"\n  },\n  \"LU\": {\n    \"country\": \"Luxembourg\",\n    \"dial_code\": \"352\"\n  },\n  \"MO\": {\n    \"country\": \"Macao\",\n    \"dial_code\": \"853\"\n  },\n  \"MK\": {\n    \"country\": \"Macedonia\",\n    \"dial_code\": \"389\"\n  },\n  \"MG\": {\n    \"country\": \"Madagascar\",\n    \"dial_code\": \"261\"\n  },\n  \"MW\": {\n    \"country\": \"Malawi\",\n    \"dial_code\": \"265\"\n  },\n  \"MY\": {\n    \"country\": \"Malaysia\",\n    \"dial_code\": \"60\"\n  },\n  \"MV\": {\n    \"country\": \"Maldives\",\n    \"dial_code\": \"960\"\n  },\n  \"ML\": {\n    \"country\": \"Mali\",\n    \"dial_code\": \"223\"\n  },\n  \"MT\": {\n    \"country\": \"Malta\",\n    \"dial_code\": \"356\"\n  },\n  \"MH\": {\n    \"country\": \"Marshall Islands\",\n    \"dial_code\": \"692\"\n  },\n  \"MQ\": {\n    \"country\": \"Martinique\",\n    \"dial_code\": \"596\"\n  },\n  \"MR\": {\n    \"country\": \"Mauritania\",\n    \"dial_code\": \"222\"\n  },\n  \"MU\": {\n    \"country\": \"Mauritius\",\n    \"dial_code\": \"230\"\n  },\n  \"YT\": {\n    \"country\": \"Mayotte\",\n    \"dial_code\": \"262\"\n  },\n  \"MX\": {\n    \"country\": \"Mexico\",\n    \"dial_code\": \"52\"\n  },\n  \"FM\": {\n    \"country\": \"Federated States of Micronesia\",\n    \"dial_code\": \"691\"\n  },\n  \"MD\": {\n    \"country\": \"Moldova\",\n    \"dial_code\": \"373\"\n  },\n  \"MC\": {\n    \"country\": \"Monaco\",\n    \"dial_code\": \"377\"\n  },\n  \"MN\": {\n    \"country\": \"Mongolia\",\n    \"dial_code\": \"976\"\n  },\n  \"ME\": {\n    \"country\": \"Montenegro\",\n    \"dial_code\": \"382\"\n  },\n  \"MS\": {\n    \"country\": \"Montserrat\",\n    \"dial_code\": \"1664\"\n  },\n  \"MA\": {\n    \"country\": \"Morocco\",\n    \"dial_code\": \"212\"\n  },\n  \"MZ\": {\n    \"country\": \"Mozambique\",\n    \"dial_code\": \"258\"\n  },\n  \"MM\": {\n    \"country\": \"Myanmar\",\n    \"dial_code\": \"95\"\n  },\n  \"NA\": {\n    \"country\": \"Namibia\",\n    \"dial_code\": \"264\"\n  },\n  \"NR\": {\n    \"country\": \"Nauru\",\n    \"dial_code\": \"674\"\n  },\n  \"NP\": {\n    \"country\": \"Nepal\",\n    \"dial_code\": \"977\"\n  },\n  \"NL\": {\n    \"country\": \"Netherlands\",\n    \"dial_code\": \"31\"\n  },\n  \"AN\": {\n    \"country\": \"Netherlands Antilles\",\n    \"dial_code\": \"599\"\n  },\n  \"NC\": {\n    \"country\": \"New Caledonia\",\n    \"dial_code\": \"687\"\n  },\n  \"NZ\": {\n    \"country\": \"New Zealand\",\n    \"dial_code\": \"64\"\n  },\n  \"NI\": {\n    \"country\": \"Nicaragua\",\n    \"dial_code\": \"505\"\n  },\n  \"NE\": {\n    \"country\": \"Niger\",\n    \"dial_code\": \"227\"\n  },\n  \"NG\": {\n    \"country\": \"Nigeria\",\n    \"dial_code\": \"234\"\n  },\n  \"NU\": {\n    \"country\": \"Niue\",\n    \"dial_code\": \"683\"\n  },\n  \"NF\": {\n    \"country\": \"Norfolk Island\",\n    \"dial_code\": \"672\"\n  },\n  \"MP\": {\n    \"country\": \"Northern Mariana Islands\",\n    \"dial_code\": \"1670\"\n  },\n  \"NO\": {\n    \"country\": \"Norway\",\n    \"dial_code\": \"47\"\n  },\n  \"OM\": {\n    \"country\": \"Oman\",\n    \"dial_code\": \"968\"\n  },\n  \"PK\": {\n    \"country\": \"Pakistan\",\n    \"dial_code\": \"92\"\n  },\n  \"PW\": {\n    \"country\": \"Palau\",\n    \"dial_code\": \"680\"\n  },\n  \"PS\": {\n    \"country\": \"Palestinian Territory\",\n    \"dial_code\": \"970\"\n  },\n  \"PA\": {\n    \"country\": \"Panama\",\n    \"dial_code\": \"507\"\n  },\n  \"PG\": {\n    \"country\": \"Papua New Guinea\",\n    \"dial_code\": \"675\"\n  },\n  \"PY\": {\n    \"country\": \"Paraguay\",\n    \"dial_code\": \"595\"\n  },\n  \"PE\": {\n    \"country\": \"Peru\",\n    \"dial_code\": \"51\"\n  },\n  \"PH\": {\n    \"country\": \"Philippines\",\n    \"dial_code\": \"63\"\n  },\n  \"PN\": {\n    \"country\": \"Pitcairn\",\n    \"dial_code\": \"872\"\n  },\n  \"PL\": {\n    \"country\": \"Poland\",\n    \"dial_code\": \"48\"\n  },\n  \"PT\": {\n    \"country\": \"Portugal\",\n    \"dial_code\": \"351\"\n  },\n  \"PR\": {\n    \"country\": \"Puerto Rico\",\n    \"dial_code\": \"1939\"\n  },\n  \"QA\": {\n    \"country\": \"Qatar\",\n    \"dial_code\": \"974\"\n  },\n  \"RO\": {\n    \"country\": \"Romania\",\n    \"dial_code\": \"40\"\n  },\n  \"RU\": {\n    \"country\": \"Russia\",\n    \"dial_code\": \"7\"\n  },\n  \"RW\": {\n    \"country\": \"Rwanda\",\n    \"dial_code\": \"250\"\n  },\n  \"RE\": {\n    \"country\": \"Reunion\",\n    \"dial_code\": \"262\"\n  },\n  \"BL\": {\n    \"country\": \"Saint Barthelemy\",\n    \"dial_code\": \"590\"\n  },\n  \"SH\": {\n    \"country\": \"Saint Helena\",\n    \"dial_code\": \"290\"\n  },\n  \"KN\": {\n    \"country\": \"Saint Kitts and Nevis\",\n    \"dial_code\": \"1869\"\n  },\n  \"LC\": {\n    \"country\": \"Saint Lucia\",\n    \"dial_code\": \"1758\"\n  },\n  \"MF\": {\n    \"country\": \"Saint Martin\",\n    \"dial_code\": \"590\"\n  },\n  \"PM\": {\n    \"country\": \"Saint Pierre and Miquelon\",\n    \"dial_code\": \"508\"\n  },\n  \"VC\": {\n    \"country\": \"Saint Vincent and the Grenadines\",\n    \"dial_code\": \"1784\"\n  },\n  \"WS\": {\n    \"country\": \"Samoa\",\n    \"dial_code\": \"685\"\n  },\n  \"SM\": {\n    \"country\": \"San Marino\",\n    \"dial_code\": \"378\"\n  },\n  \"ST\": {\n    \"country\": \"Sao Tome and Principe\",\n    \"dial_code\": \"239\"\n  },\n  \"SA\": {\n    \"country\": \"Saudi Arabia\",\n    \"dial_code\": \"966\"\n  },\n  \"SN\": {\n    \"country\": \"Senegal\",\n    \"dial_code\": \"221\"\n  },\n  \"RS\": {\n    \"country\": \"Serbia\",\n    \"dial_code\": \"381\"\n  },\n  \"SC\": {\n    \"country\": \"Seychelles\",\n    \"dial_code\": \"248\"\n  },\n  \"SL\": {\n    \"country\": \"Sierra Leone\",\n    \"dial_code\": \"232\"\n  },\n  \"SG\": {\n    \"country\": \"Singapore\",\n    \"dial_code\": \"65\"\n  },\n  \"SK\": {\n    \"country\": \"Slovakia\",\n    \"dial_code\": \"421\"\n  },\n  \"SI\": {\n    \"country\": \"Slovenia\",\n    \"dial_code\": \"386\"\n  },\n  \"SB\": {\n    \"country\": \"Solomon Islands\",\n    \"dial_code\": \"677\"\n  },\n  \"SO\": {\n    \"country\": \"Somalia\",\n    \"dial_code\": \"252\"\n  },\n  \"ZA\": {\n    \"country\": \"South Africa\",\n    \"dial_code\": \"27\"\n  },\n  \"SS\": {\n    \"country\": \"South Sudan\",\n    \"dial_code\": \"211\"\n  },\n  \"GS\": {\n    \"country\": \"South Georgia and the South Sandwich Islands\",\n    \"dial_code\": \"500\"\n  },\n  \"ES\": {\n    \"country\": \"Spain\",\n    \"dial_code\": \"34\"\n  },\n  \"LK\": {\n    \"country\": \"Sri Lanka\",\n    \"dial_code\": \"94\"\n  },\n  \"SD\": {\n    \"country\": \"Sudan\",\n    \"dial_code\": \"249\"\n  },\n  \"SR\": {\n    \"country\": \"Suricountry\",\n    \"dial_code\": \"597\"\n  },\n  \"SJ\": {\n    \"country\": \"Svalbard and Jan Mayen\",\n    \"dial_code\": \"47\"\n  },\n  \"SZ\": {\n    \"country\": \"Swaziland\",\n    \"dial_code\": \"268\"\n  },\n  \"SE\": {\n    \"country\": \"Sweden\",\n    \"dial_code\": \"46\"\n  },\n  \"CH\": {\n    \"country\": \"Switzerland\",\n    \"dial_code\": \"41\"\n  },\n  \"SY\": {\n    \"country\": \"Syrian Arab Republic\",\n    \"dial_code\": \"963\"\n  },\n  \"TW\": {\n    \"country\": \"Taiwan\",\n    \"dial_code\": \"886\"\n  },\n  \"TJ\": {\n    \"country\": \"Tajikistan\",\n    \"dial_code\": \"992\"\n  },\n  \"TZ\": {\n    \"country\": \"Tanzania\",\n    \"dial_code\": \"255\"\n  },\n  \"TH\": {\n    \"country\": \"Thailand\",\n    \"dial_code\": \"66\"\n  },\n  \"TL\": {\n    \"country\": \"Timor-Leste\",\n    \"dial_code\": \"670\"\n  },\n  \"TG\": {\n    \"country\": \"Togo\",\n    \"dial_code\": \"228\"\n  },\n  \"TK\": {\n    \"country\": \"Tokelau\",\n    \"dial_code\": \"690\"\n  },\n  \"TO\": {\n    \"country\": \"Tonga\",\n    \"dial_code\": \"676\"\n  },\n  \"TT\": {\n    \"country\": \"Trinidad and Tobago\",\n    \"dial_code\": \"1868\"\n  },\n  \"TN\": {\n    \"country\": \"Tunisia\",\n    \"dial_code\": \"216\"\n  },\n  \"TR\": {\n    \"country\": \"Turkey\",\n    \"dial_code\": \"90\"\n  },\n  \"TM\": {\n    \"country\": \"Turkmenistan\",\n    \"dial_code\": \"993\"\n  },\n  \"TC\": {\n    \"country\": \"Turks and Caicos Islands\",\n    \"dial_code\": \"1649\"\n  },\n  \"TV\": {\n    \"country\": \"Tuvalu\",\n    \"dial_code\": \"688\"\n  },\n  \"UG\": {\n    \"country\": \"Uganda\",\n    \"dial_code\": \"256\"\n  },\n  \"UA\": {\n    \"country\": \"Ukraine\",\n    \"dial_code\": \"380\"\n  },\n  \"AE\": {\n    \"country\": \"United Arab Emirates\",\n    \"dial_code\": \"971\"\n  },\n  \"GB\": {\n    \"country\": \"United Kingdom\",\n    \"dial_code\": \"44\"\n  },\n  \"US\": {\n    \"country\": \"United States\",\n    \"dial_code\": \"1\"\n  },\n  \"UY\": {\n    \"country\": \"Uruguay\",\n    \"dial_code\": \"598\"\n  },\n  \"UZ\": {\n    \"country\": \"Uzbekistan\",\n    \"dial_code\": \"998\"\n  },\n  \"VU\": {\n    \"country\": \"Vanuatu\",\n    \"dial_code\": \"678\"\n  },\n  \"VE\": {\n    \"country\": \"Venezuela\",\n    \"dial_code\": \"58\"\n  },\n  \"VN\": {\n    \"country\": \"Vietnam\",\n    \"dial_code\": \"84\"\n  },\n  \"VG\": {\n    \"country\": \"British Virgin Islands\",\n    \"dial_code\": \"1284\"\n  },\n  \"VI\": {\n    \"country\": \"U.S. Virgin Islands\",\n    \"dial_code\": \"1340\"\n  },\n  \"WF\": {\n    \"country\": \"Wallis and Futuna\",\n    \"dial_code\": \"681\"\n  },\n  \"YE\": {\n    \"country\": \"Yemen\",\n    \"dial_code\": \"967\"\n  },\n  \"ZM\": {\n    \"country\": \"Zambia\",\n    \"dial_code\": \"260\"\n  },\n  \"ZW\": {\n    \"country\": \"Zimbabwe\",\n    \"dial_code\": \"263\"\n  }\n}' WHERE `general_settings`.`id` = 1;

UPDATE users SET dial_code = ( SELECT JSON_UNQUOTE(JSON_EXTRACT(country_list, CONCAT('$."', users.country_code, '".dial_code'))) FROM general_settings WHERE JSON_CONTAINS_PATH(country_list, 'one', CONCAT('$."', users.country_code, '"')) );

UPDATE users SET mobile = SUBSTRING(mobile, CHAR_LENGTH(dial_code) + 1);

-- for organizers 
UPDATE organizers SET dial_code = ( SELECT JSON_UNQUOTE(JSON_EXTRACT(country_list, CONCAT('$."', organizers.country_code, '".dial_code'))) FROM general_settings WHERE JSON_CONTAINS_PATH(country_list, 'one', CONCAT('$."', organizers.country_code, '"')) );

UPDATE organizers SET mobile = SUBSTRING(mobile, CHAR_LENGTH(dial_code) + 1);

ALTER TABLE `general_settings` DROP `country_list`;

INSERT INTO `update_logs` (`id`, `version`, `update_log`, `created_at`, `updated_at`) VALUES (NULL, '2.0', '[\"[ADD] Push Notification\",\r\n\"[ADD] Social Login\",\r\n\"[ADD] Binance Payment Gateway\",\r\n\"[ADD] Aamarpay Payment Gateway\",\r\n\"[ADD] SslCommerz Payment Gateway\",\r\n\"[ADD] Slug Management for Blogs\",\r\n\"[ADD] SEO Content Management for Blog\",\r\n\"[ADD] Slug Management for Policy Pages\",\r\n\"[ADD] SEO Content Management for Policy Pages\",\r\n\"[ADD] Input type number, url, date, and time in the Form Generator\",\r\n\"[ADD] Configurable Input Filed Width in the Form Generator\",\r\n\"[ADD] Configurable Hints/Instructions for Input Fields in the Form Generator\",\r\n\"[ADD] Sorting Option for Input Fields in the Form Generator\",\r\n\"[ADD] Controllable Login System with Google, Facebook, Linkedin\",\r\n\"[ADD] Automatic System Update\",\r\n\"[ADD] Image on Deposit And Withdraw Method\",\r\n\"[ADD] Configurable Number of Items Per Page for Pagination\",\r\n\"[ADD] Configurable Currency Display Format\",\r\n\"[ADD] Redirecting to Intended Location When Required\",\r\n\"[ADD] Resend Code Countdown on Verification Pages\",\r\n\"[ADD] Cron Jobs\",\r\n\"[ADD] Cron Schedule\",\r\n\"[ADD] Cron Job Logs\",\r\n\"[ADD] Cron job Instruction UI\",\r\n\"[UPDATE] Admin Dashboard Widget Design\",\r\n\"[UPDATE] Notification Sending Process\",\r\n\"[UPDATE] User Experience of the Admin Sidebar\",\r\n\"[UPDATE] Improved Menu Searching Functionality on the Admin Panel\",\r\n\"[UPDATE] User Experience of the Select Fields of the Admin Panel\",\r\n\"[UPDATE] Centralized Settings System\",\r\n\"[UPDATE] Form Generator UI on the Admin Panel\",\r\n\"[UPDATE] Google Analytics Script\",\r\n\"[UPDATE] Notification Toaster UI\",\r\n\"[UPDATE] Support Ticket Attachment Upload UI\",\r\n\"[UPDATE] Notification Template Content Configuration\",\r\n\"[UPDATE] Configurable Email From Name and Address for Each Template\",\r\n\"[UPDATE] Configurable SMS From for Each Template\",\r\n\"[UPDATE] Overall User Interface of the Admin Panel\",\r\n\"[PATCH] Laravel 11\",\r\n\"[PATCH] PHP 8.3\",\r\n\"[PATCH] Latest System Patch\",\r\n\"[PATCH] Latest Security Patch\"]', '2024-05-26 21:55:52', '2024-05-26 21:55:52');

UPDATE gateways SET image = '663a38d7b455d1715091671.png' WHERE code = 101;
UPDATE gateways SET image = '663a3920e30a31715091744.png' WHERE code = 102;
UPDATE gateways SET image = '663a39861cb9d1715091846.png' WHERE code = 103;
UPDATE gateways SET image = '663a39494c4a91715091785.png' WHERE code = 104;
UPDATE gateways SET image = '663a390f601191715091727.png' WHERE code = 105;
UPDATE gateways SET image = '663a38c9e2e931715091657.png' WHERE code = 106;
UPDATE gateways SET image = '663a38fc814e91715091708.png' WHERE code = 107;
UPDATE gateways SET image = '663a36c2c34d61715091138.png' WHERE code = 109;
UPDATE gateways SET image = '663a393a527831715091770.png' WHERE code = 110;
UPDATE gateways SET image = '663a3995417171715091861.png' WHERE code = 111;
UPDATE gateways SET image = '663a384d54a111715091533.png' WHERE code = 112;
UPDATE gateways SET image = '663a35efd0c311715090927.png' WHERE code = 501;
UPDATE gateways SET image = '663a36a8d8e1d1715091112.png' WHERE code = 503;
UPDATE gateways SET image = '663a36b7b841a1715091127.png' WHERE code = 504;
UPDATE gateways SET image = '663a368e753381715091086.png' WHERE code = 505;
UPDATE gateways SET image = '663a367e46ae51715091070.png' WHERE code = 506;
UPDATE gateways SET image = '663a38ed101a61715091693.png' WHERE code = 113;
UPDATE gateways SET image = '663a39afb519f1715091887.png' WHERE code = 114;
UPDATE gateways SET image = '663a387ec69371715091582.png' WHERE code = 115;
UPDATE gateways SET image = '663a361b16bd11715090971.png' WHERE code = 116;
UPDATE gateways SET image = '663a386c714a91715091564.png' WHERE code = 119;
UPDATE gateways SET image = '663a35b9ca5991715090873.png' WHERE code = 120;
UPDATE gateways SET image = '663a3897754cf1715091607.png' WHERE code = 121;
UPDATE gateways SET image = '663a35cd25a8d1715090893.png' WHERE code = 507;
UPDATE gateways SET image = '663a38b8d57a81715091640.png' WHERE code = 508;
UPDATE gateways SET image = '663a38a59d2541715091621.png' WHERE code = 509;
UPDATE gateways SET image = '663a39b8e64b91715091896.png' WHERE code = 122;
UPDATE gateways SET image = '663a3628733351715090984.png' WHERE code = 123;
UPDATE gateways SET image = '663b50fc3b21c1715163388.png' WHERE code = 1000;
UPDATE gateways SET image = '663a35db4fd621715090907.png' WHERE code = 510;
UPDATE gateways SET image = '663a397a70c571715091834.png' WHERE code = 124;
UPDATE gateways SET image = '663a34d5d1dfc1715090645.png' WHERE code = 125;


INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `seo_content`, `tempname`, `slug`, `created_at`, `updated_at`) VALUES (NULL, 'register_disable.content', '{\"has_image\":\"1\",\"heading\":\"Registration Currently Disabled\",\"subheading\":\"Page you are looking for doesn\'t exit or an other error occurred or temporarily unavailable.\",\"button_name\":\"Go to Home\",\"button_url\":\"#\",\"image\":\"663a0f20ecd0b1715080992.png\"}', NULL, 'basic', NULL, '2024-05-07 11:23:12', '2024-05-07 11:23:12');


