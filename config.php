<?php
define( 'DB_NAME', 'DATABASE_NAME' );
define( 'DB_USER', 'DATABASE_USER' );
define( 'DB_PASSWORD', 'DATABASE_PASSWORD' );
define( 'DB_HOST', 'DATABASE_SERVER' );
define( 'DB_CHARSET', 'DATABASE_CHATSET' );
define( 'DB_COLLATE', '' );
define( 'AUTH_KEY',         'WP_AUTH_KEY' );
define( 'SECURE_AUTH_KEY',  'WP_SECURE_AUTH_KEY' );
define( 'LOGGED_IN_KEY',    'WP_LOGGED_IN_KEY' );
define( 'NONCE_KEY',        'WP_NONCE_KEY' );
define( 'AUTH_SALT',        'WP_AUTH_SALT' );
define( 'SECURE_AUTH_SALT', 'WP_SECURE_AUTH_SALT' );
define( 'LOGGED_IN_SALT',   'WP_LOGGED_IN_SALT' );
define( 'NONCE_SALT',       'WP_NONCE_SALT' );
$table_prefix = 'WP_PREFIX_TABLE';

define( 'WP_DEBUG', SET_WP_DEBUG );

if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

require_once ABSPATH . 'wp-settings.php';

